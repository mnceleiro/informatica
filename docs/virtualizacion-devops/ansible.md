# Aprovisionamiento con Ansible
Ansible es una herramienta de **gestión de la configuración** (otras anteriores fueron **Puppet** y **Chef**) de código abierto que nos permite automatizar tareas en distintos equipos que podemos tener en una o varias redes. Por ejemplo: instalación de software, copia de archivos, arranque de servicios, implementación de reglas de seguridad, etc.

Ansible fue creado en 2012 por Michael Dehann, está escrito en Python y usa  ficheros YAML para la configuración. Aprovisiona (instala software, arranca servicios, crea archivos...) en ordenadores remotos utilizando SSH (esto es, debemos tener un servidor SSH instalado en las máquinas que queremos aprovisionar).

En Ansible no declaramos que queremos instalar un software, sino que declaramos **el estado que queremos de ese software**. Por ejemplo

=== "Lo que HACEMOS"

    ```yaml
      tasks:
        - name: Instalar Nginx
          apt:
            name: nginx
            state: present
    ```

No le decimos que queremos instalar algo, sino que queremos **que se encuentre instalado en nuestro sistema**. Es decir, Ansible se debe asegurar de que esté siempre presente Nginx, comprobará si no lo está y hará cambios de ser necesario.

En Ansible, al igual que se hace en herramientas de gestión de la configuración anteriores como Chef y Puppet, se declara el estado deseado (present o absent en este caso) y Ansible se ocupa de que siempre se encuentre en ese estado.

La mayoría de módulos que vienen con Ansible (por ejemplo el módulo apt usado en el ejemplo anterior) son **idempotentes**. Esto es, que si aplicamos una configuración muchas veces, siempre obtenemos el mismo resultado. 

## Requisitos
Necesitas dos máquinas virtuales para empezar a practicar. Usaremos Ubuntu 22.04 o 24.04 en ambas:

- **Máquina de control** (es la única donde instalaremos Ansible). Esta máquina se encarga de aprovisionar al resto.
- **Máquina gestionada** (una máquina cualquiera de la red que aprovisionamos con Ansible).

A continuación te aporto un script de Vagrant que crea dos máquinas con Ubuntu 22.04, pero puedes utilizar otras o un servicio en la nube si lo prefieres (p. ej: puedes hacerlo creando dos máquinas en AWS):

```ruby title="Vagrantfile para creación de 2 VMs"
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.define "control" do |control|
    control.vm.box = "ubuntu/jammy64"
    control.vm.hostname = "ansible-control"
    control.vm.network "private_network", ip: "192.168.33.100",
      virtualbox__intnet: true

      control.vm.provider :virtualbox do |virtualbox|
      virtualbox.name = "ansible-control"
      virtualbox.cpus = 1
      virtualbox.memory = 2048
      virtualbox.customize ["modifyvm", :id, "--groups", "/vagrant-ansible"]
    end
  end

  config.vm.define "equipo1" do |equipo1|
    equipo1.vm.box = "ubuntu/jammy64"
    equipo1.vm.hostname = "ansible-equipo1"
    equipo1.vm.network "private_network", ip: "192.168.33.101",
      virtualbox__intnet: true

      equipo1.vm.provider :virtualbox do |virtualbox|
      virtualbox.name = "ansible-equipo1"
      virtualbox.cpus = 1
      virtualbox.memory = 2048
      virtualbox.customize ["modifyvm", :id, "--groups", "/vagrant-ansible"]
    end
  end
end
```

!!! Tarea
    1. Arranca las máquinas.
    2. Entra en la máquina de control.

## Instalación de Ansible en Ubuntu
Hay dos maneras de instalar Ansible, escoge una:

### Opción 1: APT
=== "APT"

    ```bash title="Instalando Ansible con APT"
    # Anhadimos repositorio oficial de Ansible
    sudo apt‐add‐repository ppa:ansible/ansible
    sudo apt update

    # Prerrequisitos
    sudo apt install -y python3

    # Instalamos Ansible
    sudo apt install ansible -y

    # Comprobamos instalación correcta y versión
    ansible --version
    ```

=== "PIP"

    ```bash title="Instalar Ansible con Python y pip"
    sudo apt install -y python3
    # TODO: mostrar instalación con pip (instalar python y pip, entorno virtual y ansible)
    
    ```

!!! Tarea
    Instala ansible en la máquina de control.

## Empezando a trabajar con Ansible: generando y copiando claves SSH
Antes de nada, para hacer cosas en equipos remotos **Ansible utiliza SSH**. Por tanto, tenemos que:

1. Generar un par de claves en el equipo de control
2. Pasar la clave pública a todos los equipos remotos. 
3. Ahora tenemos la clave privada y los equipos a aprovisionar tienen la clave pública. La máquina de control podrá conectarse a los equipos para aprovisionarlos.

### Generando claves pública y privada en "control"
En este caso tenemos solo un equipo remoto que queremos "controlar". Por esta razón, debemos generar las claves SSH en control y poner la clave pública en el authorized_keys del equipo remoto.

Esto puede hacerse de la siguiente manera. Desde "control" escribimos el siguiente comando:

```
ssh-keygen -t rsa -b 4096
```

No pongas passpharse. Una vez ejecutado el comando deberían generarse las claves en ~/.ssh/id_rsa y ~/.ssh/id_rsa.pub. 

### Copiando la clave pública de "control" a "equipo1"
Tenemos que pasar la clave pública al otro equipo, para ello podemos copiarla en la carpeta /vagrant (está compartida por defecto por todos los hosts).

```
cp ~/.ssh/id_rsa.pub /vagrant
```

Comprobamos que vemos la clave desde **equipo1**:
```
cat /vagrant/id_rsa.pub
```

Si la vemos sin problema, ahora basta con añadir su contenido al fichero authorized_keys:
```
cat /vagrant/id_rsa.pub >> ~/.ssh/authorized_keys
```
Hecho de esta forma (con >>) no sobreescribimos ninguna otra que pudiera haber antes. Además, al no copiar el fichero sino su contenido nos evitamos problemas que podríamos tener con los permisos del fichero que tiene la clave.

### Probando la conexión SSH
Comprueba que puedes acceder por SSH sin contraseña desde "control" a "equipo1".

## Empezando a trabajar con Ansible: inventario
Para la configuración de Ansible se usan ficheros yaml (o yml) o ficheros clave=valor (.ini). Los ficheros yaml son similares a un JSON, aunque no usan llaves de apertura y cierre. De momento vamos a centrarnos en los INI, que son más sencillos.

Podemos crear un fichero de inventario con la lista de hosts que tenemos (en nuestro caso, podría ser solo nuestra máquina gestionada o ambas). En este caso vamos a usar **la ubicación predeterminada que Ansible busca si no se especifica nada**.

```ini title="Fichero ejemplo de inventario en /etc/ansible/hosts"
[equipos]
gandalf ansible_host=IP_equipo ansible_user=nombre_usuario
arwen ansible_host=IP_equipo ansible_user=nombre_usuario
frodo ansible_host=IP_equipo ansible_user=nombre_usuario
```

!!! Nota
    Por defecto, el inventario en Ansible está en **/etc/ansible/hosts**.

En este caso, hemos creado el grupo "equipos" con 3 hosts (a los que les indicamos el nombre del host, la ip del equipo y el usuario).

Para comprobar si ansible reconoce el inventario podemos usar el siguiente comando:

```
# Muestra la información de todos los hosts del inventario
ansible-inventory --list -y

# Comprueba conectividad contra el grupo "mis_equipos". -m indica que usa el módulo "ping" de Ansible
ansible mis_equipos -m ping
```

!!! Tarea
    1. Crea el fichero indicado con los datos del host que quieres aprovisionar (equipo1).
    2. Comprueba que el inventario está correcto (muestra todos los hosts del inventario con el comando mostrado anteriormente).
    3. Mira para qué sirven las opciones --list y -y indicadas en el comando ejecutado (revisa el manual de ansible-inventory para ver para qué sirven y que cambiaría no ponerlas).
    4. Comprueba si hay ping a los hosts de "mis_equipos" (de forma normal, con un "ping" típico y luego con ansible).
    5. Prueba ahora a hacer ping a TODOS los equipos con Ansible (en este caso coincide que todos los equipos están en el grupo "mis_equipos", por lo que no veremos diferencia). Puedes hacer ping a todos los equipos con Ansible cambiando el grupo ("mis_equipos") por "all".

### Resumen sobre inventarios
- El inventario de Ansible se encuentra, por defecto, en **/etc/ansible/hosts**.
- Podemos comprobar la conexión con los equipos definidos en el inventario con el comando `ansible <equipos> <ruta_al_inventario> -m ping`.
- Los ficheros de inventario se pueden crear en formato ini (el que hemos hecho) o JSON.

### Inventario con varios grupos de hosts
Un ejemplo de un inventario con varios grupos de hosts podría ser el siguiente:
```ini
[webservers]
web1 ansible_host=192.168.1.10 ansible_user=ubuntu
web2 ansible_host=192.168.1.11 ansible_user=ubuntu

[databases]
db1 ansible_host=192.168.1.20 ansible_user=root

[all:vars]
ansible_ssh_private_key_file=~/.ssh/id_rsa
```

El grupo final [all:vars] configura opciones que son comunes para todos los hosts. En este caso, indicamos que use esa clave privada para conectarse con cualquier host remoto.

### Ejemplo con múltiples claves privadas para diferentes hosts
Si queremos, podemos indicar la clave privada a utilizar directamente donde definimos el host:
```ini
[webservers]
web1 ansible_host=192.168.1.10 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
web2 ansible_host=192.168.1.11 ansible_user=admin ansible_ssh_private_key_file=~/.ssh/admin_key.pem
```

### Ejemplo simple: solo con el host
Uno de los ejemplos más simple de inventario que podemos hacer sería el siguiente:
```ini
[web]
host1.murallaromana.com
host2.murallaromana.com
host3.murallaromana.com

[db]
db.murallaromana.com
db2.murallaromana.com
```

Tenemos 2 grupos de hosts, pero solo hemos puesto el dominio donde se encuentran (podríamos poner también la ip). Entonces, ¿qué usuario usará Ansible para intentar conectarse por SSH?

Usará el **mismo usuario de la máquina de control**. Esto es, si en las dos máquinas está el usuario "vagrant" y la clave privada está en su ruta por defecto, la conexión debería tener éxito.

!!! Tarea
    1. Haz una copia del inventario que has creado en el ejercicio anterior. Ahora, modifícalo para simplificarlo como en el ejemplo (solo con las ips de las máquinas).

## Empezando a trabajar con Ansible: Playbooks
Los ficheros *Playbook* definen las tareas que ejecutarán los hosts del inventario. Para definir los Playbooks se usan ficheros YAML (similares a JSON).

A continuación se muestran dos ejemplos sencillos:

=== "Comprueba la conexión"

    ```yaml title="Usando el módulo PING"
    ---
    - hosts: all
      tasks:
        - name: Comprueba que podemos conectarnos a las máquinas
          ping:
    ```

=== "Instalación Apache"

    ```yaml title="Asegura que Apache esté instalado"
    ---
    - hosts: all
      tasks:
        - name: Instalar Apache
          apt:
            name: apache2
            state: present
    ```

Los .yml de Ansible siguen el siguiente formato:

- Empiezan por tres guiones: **---**
- Siguen con la sección de hosts: **- hosts: all**.
- Siguen con la sección de las tareas a realizar: **tasks: ...**

### Mi primer Playbook: creando un fichero

Vamos a crear un playbook sencillo.

```yaml
---
- name: Mi primer Playbook 
  hosts: mis_equipos
  tasks:
    - name: Escribir mensaje en un archivo en equipo1
      shell: echo "Hello world desde Ansible!" >> /home/vagrant/hello_world.txt
```

Los Playbooks se pueden ejecutar con el comando `ansible-playbook`:
```bash
ansible-playbook <nombre_fichero>.yml
``` 

!!! Tarea
    En esta tarea realizarás la primera tarea de aprovisionamiento sobre las máquinas que gestiona Ansible (en este caso solo "equipo1").

    1. Indica, leyendo el anterior playbook de ejemplo, qué crees que hará.
    2. Crea el playbook de ping del ejemplo anterior (equivalente al comando ansible-playbook -m ping que has ejecutado anteriormente).
    3. Ejecuta el playbook.
    4. Crea el Playbook "Mi primer Playbook" en **~/ansible/playbooks/1-hello.yml**. Tendrás que crear las carpetas en tu home.
    5. Ejecuta el Playbook y verifica que hace lo que se supone que debe hacer.

### Uso de variables
Vamos a modificar el ejemplo anterior para utilizar una variable para el mensaje de saludo.

```yaml title="2-hello-variables.ytml"
---
- name: Hello World con Variable
  hosts: mis_equipos
  vars:
    saludo: "Hello world desde Ansible!"
  tasks:
    - name: Mostrar el mensaje con la variable
      shell: echo "{{ saludo }}" >> /home/vagrant/hello_world_variable.txt
```

!!! Tarea
    Prueba el script anterior.

### Instalación de software
Ahora vamos a ir con un Playbook un poco más complejo. Este Playbook instala (en caso de que no lo esté ya) el servidor web Nginx.

```yaml
---
- name: Instalar Nginx si no está instalado
  hosts: mis_equipos
  become: true # Si añadimos esto hacemos que Ansible se haga administrador para las tareas
  tasks:
    - name: Instalar Nginx
      apt:
        name: nginx
        state: present
```

!!! Tarea
    1. Razona lo que hace el fichero anterior.
    2. Crea el fichero **3-nginx.yml** con el contenido anterior y comprueba que hace lo que tiene que hacer. Puedes comprobarlo usando en la máquina gestionada el comando nginx -v.
    3. Ahora, crea el fichero **4-nginx-absent.yml** para desinstalar nginx. Es muy similar al anterior, pero el estado debe ser ausente (absent) en lugar de presente (present) y además haz que "nginx" sea una variable. *Revisa que nginx se elimine completamente (pista: puede que no lo haga), si no lo hace revisa la [documentación del módulo apt de ansible](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/apt_module.html) e intenta añadir alguna propiedad más que haga que se elimine tanto nginx como los paquetes relacionados con él.*
    4. De nuevo, comprueba el funcionamiento con nginx -v en la máquina gestionada.

### Bucles
Anteriormente hemos instalado nginx, pero muchas veces se necesitan gran cantidad de paquetes para una sola instalación. Por ejemplo, para una instalación de Wordpress necesitamos, al menos: tener php instalado, tener el paquete php-mysql, tener mysql-server, tener la compatibilidad de Apache con PHP instalada (libapache2-mod-php), etc.

Vamos a ver como instalar varios paquetes juntos:

```yaml title="5-instalacion-con-bucles.yml"
---
- name: Instalar varios paquetes
  hosts: mis_equipos
  become: true
  tasks:
    - name: Instalar paquetes
      apt:
        name: "{{ item }}"
        state: present
      loop:
        - nginx
        - vim
        - curl
```

!!! Tarea
    Prueba el script anterior.


### Bucles sobre variables
Se pueden definir listas de variables y luego iterar sobre ellas:

```yaml title="6-instalacion-con-bucles-2.yml"
---
- name: Instalar varios paquetes desde una variable
  hosts: mis_equipos
  become: true
  vars:
    paquetes:
      - nginx
      - vim
      - curl
  tasks:
    - name: Instalar paquetes desde la variable
      apt:
        name: "{{ item }}"
        state: present
      loop: "{{ paquetes }}"
```

{{ item }} representa siempre a un elemento en un bucle. Por su parte, en loop: {{ paquetes }} le indicamos que queremos iterar sobre la lista de "paquetes" (nginx, vim y curl).

!!! Tarea
    Crea el fichero anterior y prueba el playbook.

Aunque se ha usado este ejemplo para ver el tema de bucles, la instalación de paquetes podría hacerse más sencilla:

```yaml title="5-instalacion-con-bucles.yml"
---
- name: Instalar varios paquetes
  hosts: mis_equipos
  become: true
  tasks:
    - name: Instalar paquetes
      apt:
        state: present
        update_cache: true # apt update
        name:
        - nginx
        - vim
        - curl
```

### Condicionales
Los condicionales (habitualmente *if* en lenguajes de programación) aquí se definen con **when** (cuando...).

```yaml title="7-condicionales.yml"
---
- name: Instalar apache solo si la variable instalar_apache es true
  hosts: mis_equipos
  tasks:
    - name: Instalar Apache
      apt:
        name: apache
        state: present
      when: instalar_apache == true
```

!!! Tarea
    1. Trata de entender el funcionamiento del código anterior.
    2. Copia y ejecuta el playbook anterior.
    3. El Playbook anterior tiene 2 problemas. Soluciónalos.


Vamos a ver otro ejercicio ahora incluyendo ficheros:
- **stat**: módulo que obtiene información de un fichero o carpeta. Si quieres ver lo que hace ejecuta el comando en Linux (stat fichero).
- **register**: guarda el resultado de una tarea en una variable (en el caso siguiente sería en "archivo_estatico").

```yaml title="8-condicionales-con-ficheros.yml"
---
- name: Verificar existencia de un archivo
  hosts: mis_equipos
  become: true
  tasks:
    - name: Comprobar si el archivo existe
      stat:
        path: /home/vagrant/hello_world.txt
      register: archivo_estatico

    - name: Mostrar mensaje si el archivo no existe
      debug:
        msg: "El archivo hello_world.txt no existe."
      when: archivo_estatico.stat.exists == false
```

!!! Tarea
    1. Prueba el playbook anterior.
    2. Añade el código necesario para que también muestre un mensaje de debug en caso de que el fichero exista.
    3. Crea un nuevo fichero **9-condicionales-ejecutar-comando.yml** que, en caso de que la variable "habilitar_firewall" sea "true", ejecute el comando para habilitar ufw (ufw enable). Para ejecutar un comando en una tarea solo tienes que poner: "command: el_comando". 

Otro ejercicio:

```yaml
---
- name: Si el sistema operativo que usamos es Ubuntu, instala nginx
  hosts: mis_equipos
  tasks:
    - name: Comprobar si el sistema operativo es Ubuntu
      command: lsb_release -is  # Comando que devuelve el nombre del sistema operativo
      register: so              # Guardamos la salida en la variable 'so'
      changed_when: false       # No marcamos esta tarea como "cambiada" ya que solo obtiene información

    - name: Instalar nginx solo en Ubuntu si no está instalado
      apt:
        name: nginx
        state: present
      when: so.stdout == "Ubuntu" and ansible_facts.packages['nginx'] is not defined  # Condición
```

- **ansible_facts**: los hechos (facts) son detalles del sistema (paquetes instalados, versiones, ips, sistema operativo que usamos, etc.). La variable ansible_facts se usa en Ansible para almacenar esa información.
- **changed_when**: por defecto Ansible, al ejecutarse, marca que se ha realizado un cambio. En un caso como este, en que solo obtenemos información (lsb_release nos da información del sistema pero no hace nada sobre él) podemos indicarle a Ansible que no se han hecho cambios reales en el sistema: *changed_when: false*.

!!! Tarea
    1. El playbook anterior instala nginx si usamos Ubuntu. Pruébalo.

## Repaso
Podemos ejecutar un ping a un equipo (por nombre), a un grupo de hosts (mis_equipos) o a todos los hosts (all) directamente con:
```bash title="Hacemos un ping a todos los equipos"
ansible all -m ping
```

Se puede llegar a lo mismo usando un fichero de configuración:
```yaml title="comprobacion-ping-equipo1.yml"
---
- hosts: equipo1
  tasks:
    - name: Comprueba que podemos conectarnos a las máquinas
      ping:
```

Podemos ejecutar un Playboook (p. ej: el anterior) con:
```bash
ansible-playbook ruta/a/comprobacion-ping-equipo1.yml # podemos añadir -v para ver mas información
```

El inventario se encuentra por defecto en /etc/ansible/hosts. Si queremos usar un inventario situado en otro sitio (que es lo más común) podemos usar el siguiente comando:
```bash
ansible-playbook -i /vagrant/hello_world_ansible/inventory /vagrant/hello_world_ansible/playbooks/1-hello.yml 
```

Lo mismo con ruta relativa (situándonos antes en la carpeta /vagrant/hello_world_ansible):
```bash
ansible-playbook -i ./inventory ./1-hello.yml   # Se puede omitir el ./
```

Para ver información de tu inventario puedes usar el comando `ansible-inventory`:
```bash title="Ver inventario en formato yaml (-y)
ansible-inventory -i inventory --list -y  # Sin -y se muestra en formato json
```

!!! Tarea I
    Prueba todos esos comandos en tu máquina.


!!! Tarea II
    1. Crea una carpeta tarea-2 y en ella haz un fichero de inventario (basicamente el mismo que ya tienes, pero ahora no vamos a usar el /etc/ansible/hosts sino que vamos a tener el inventario en la carpeta de nuestro proyecto).
    2. Comprueba el ping con el inventario (indica que use el que acabamos de crear, no el viejo).
    3. Guiandote y combinando los playbooks que ya hemos creado antes, vamos a crear uno que nos permita instalar Apache con PHP, copiar ficheros PHP de un proyecto local que tengamos a remoto. Los pasos son los siguientes: 1. crear el fichero de playbook, instalar Apache, instalar php, instalar otras dependencias si son necesarias y, finalmente, copiar tus ficheros php a /var/www/html.

!!! Tarea III
    1. Crea una copia de tarea-2 con el nombre tarea-3. 
    2. Ahora, modifícalo para copiar un proyecto PHP que use también base de datos (hay que configurar con ansible la creación de la base de datos e indicar el usuario y contraseña). Para ello, revisa [el módulo de MySQL](https://docs.ansible.com/ansible/latest/collections/community/mysql/index.html) de Ansible.

## Trabajo
Añade una tercera máquina a la configuración de Vagrant y instala en ella uno de los siguientes sevicios:

1. Nextcloud: Servicio en la nube (estilo Dropbox/Google Drive) pero en nuestro propio disco.
2. Wordpress: Gestor de contenidos web.
3. Zabbix: monitorización de equipos (cuando son apagados, encendidos, estados erróneos, etc.).
4. Otros: consultar antes.

Finalmente, haz una configuración básica. Por ejemplo, si usas Nextcloud conéctate a él desde una aplicación de escritorio o móvil, si usas Wordpress cambia la plantilla y añade alguna entrada en el blog, si usas Zabbix añade los otros equipos de la red.

## Inventario
El inventario en ansible es la lista de equipos que aprovisionamos. **Por defecto, el inventario se encuentra en /etc/ansible/hosts**, pero podemos poner el inventario en donde queramos (lo normal es tener un proyecto con todo).

El fichero de inventario puede ser implementado como INI o YAML.

## TODO
- Inventarios con hijos: debian:children (que incluya debian 11 y 12 por ejemplo).
- Desplegar playbooks en AWS/Azure.
- Ansible en sistemas Windows.
- Ansible Galaxy (desglose del trabajo anterior usando ansible-galaxy en roles).
- Exploración del repo de Ansible Galaxy: https://galaxy.ansible.com/
- Variables de inventario (inventory/host_vars e inventory/group_vars).
- Facts, comprobar facts, deshabilitar facts (gather_facts: false), creación de facts con facts.d y ext .fact, config de cacheo de facts.
- hostvars, manipulación de variables.
- Precedencia de variables de menor a mayor: 
  - Por defecto en los roles: defaults/main.yml
  - Inventario (inline, [nombre:vars])
  - Inventario (group_vars)
  - Inventario (host_vars)
  - Variables de grupo (group_vars) a nivel de playbook (al lado del playbook.yml).
  - Lo mismo pero de host de playbook (host_vars)
  - Facts de host
  - Variables registradas con "register:".
  - Facts definidos con set_fact.
  - Variables de playbook (definidas en la sección vars de un playbook).
  - Variables de playbook (definidas con vars_prompt, interactivas).
  - Variables de playbook (en ficheros, con vars_files).
  - Variables de playbook en un rol concreto (variables de rol, lo mismo que variables de playbook pero dentro del rol).
  - Variables de playbook en un bloque (block).
  - Variables de playbook dentro de las tareas (dentro de tasks).
  - Variables especificadas como parámetro en un comando con `ansible-playbook`. o especificando un fichero de variables.
- Buenas prácticas.