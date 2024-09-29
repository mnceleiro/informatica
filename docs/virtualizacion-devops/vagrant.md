# Gestión de máquinas virtuales con Vagrant
Vagrant es un software que requiere tener detrás otras aplicaciones de virtualización. Algunas compatibles son: VirtualBox, VMWare e HyperV.

## Descarga e instalación
Entra en [www.vagrantup.com](https://www.vagrantup.com){target="_blank"} y descarga e instala Vagrant:
![download vagrant](files/images/vagrant-download.png)

Una vez instalado se te pedirá reiniciar. Para comprobar si Vagrant funciona correctamente abre un CMD o Powershell y ejecuta el comando "vagrant". 

Si funciona saldrá algo como lo de la imagen siguiente:
![vagrant works](files/images/vagrant-test-itworks.png)

## Creación de la primera máquina virtual con Vagrant

### Creando un Vagrantfile con "vagrant init"
Crea una carpeta donde almacenar los scripts de Vagrant. Yo, por ejemplo, los guardaré en:

- *C:/Users/<tu-usuario\>/Documentos/clases/scripts-vagrant/*. 

Ahora, vamos a crear nuestro primer script que guardaremos en: 

- C:/Users/<tu-usuario\>/Documentos/clases/scripts-vagrant/0-probando-vagrant.

Sitúate en la carpeta "0-probando-vagrant" desde un terminal. Una vez ahí, ejecuta el siguiente comando:

```
vagrant init
```

![vagrant init captura](files/images/vagrant-init.png)

Si has hecho todo bien, al abrir el Vagrantfile debería aparecer un fichero de más de 60 líneas (con casi todo comentarios iniciados con el caracter "#"). **Vamos a borrar esos comentarios** y el script debería quedar así:

```rb title="Vagrantfile"
Vagrant.configure("2") do |config|
  config.vm.box = "base"
end
```

La línea importante a fijarnos aquí es: **config.vm.box = "base"**. Una box de Vagrant es basicamente una imagen de una máquina virtual exportada destinada a usarse en Vagrant.

Si consultamos la [el quickstart de la documentación oficial](https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-project-setup), en él utilizan como box "hashicorp/bionic64", vamos a cambiar el script para adaptarlo a la documentación oficial.

!!! info "Ejercicio"
    Modifica el Vagrantfile para que utilice como imagen de máquina virtual (en vagrant conocida con el nombre de "box") la que sale en la documentación oficial: *hashicorp/bionic64*

```rb title="Solución"
Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"
end
```

### Comprobación de que el Vagrantfile está correctamente
Existe un comando para comprobar que el script está correcto y sin errores, este comando es:

=== "Comando"

    ```
    vagrant validate
    ```
=== "Resultado esperado"

    ```
    Vagrantfile validated successfully.
    ```

### Descargar y encender la máquina
Ahora, situado en la carpeta donde tengas el Vagrantfile, ejecuta el comando:
```
vagrant up
```

Este comando lee el Vagrantfile, descarga la box (si no estaba descargada anteriormente), crea la máquina virtual y la enciende. Cuando el comando termine tu máquina estará encendida (aunque no verás la interfaz gráfica).

!!! Note "Nota"
    - :question: Una vez termine la ejecución del "vagrant up", si no ha dado errores, **abre Virtualbox, ¿ves algo nuevo?**

    - :thumbsup: Si el comando tuvo éxito **deberías ver la nueva máquina virtual**. Esto es porque **Vagrant utiliza por detrás Virtualbox como provider** (si alguna vez recibes algún error en Vagrant en que veas la palabra "provider", está relacionado con Virtualbox). 
    
    - :information_source: Existen otros providers (VMWare o HyperV) compatibles con Vagrant.

Esto descargará la máquina, la configurará con unos parámetros por defecto y la arrancará. No te preocupes por no ver ninguna máquina en la interfaz gráfica, esto es normal.

### Conexión con la máquina virtual
**En vagrant, por defecto, la máquina se inicia sin la interfaz gráfica.** Esto también es posible hacerlo en Virtualbox (recuerda, usamos Virtualbox como provider y estamos, por tanto, limitados a lo que se puede hacer en Virtualbox). 

| ![Inicio sin interfaz gráfica en Virtualbox](files/images/virtualbox-inicio-sin-gui.png) |
| :-: |
| *Captura de ejemplo de como iniciar una máquina sin pantalla en Virtualbox* |

!!! question "Pero, si no tiene pantalla ¡¿cómo demonios la uso?!"

    No problem :ok_hand: :person_gesturing_ok:
    
    Las boxes de Vagrant vienen con conexión remota configurada, por lo que podemos conectarnos a la máquina remotamente de forma transparente con el comando: *vagrant ssh*

!!! Note "Ejercicio"
    Ejecuta el comando "vagrant ssh" para conectarte a la máquina. 

    **Importante**: ejecuta el comando desde la carpeta donde tienes el Vagrantfile

![Conexión remota a la máquina virtual con vagrant ssh](files/images/vagrant-ssh.png)

### Apagando la máquina virtual
Para apagar la máquina se usa el comando:

```
vagrant halt
```

!!! Note "Ejercicio"

    1. Abre Virtualbox.
    2. Escribe el comando "vagrant halt" y fíjate si la máquina se apaga.

También se puede comprobar si la máquina está apagada con comandos de Vagrant. Comprueba que la máquina está apagada usando el comando 

```
vagrant status
```

### Examinando las propiedades de la máquina virtual
Hemos creado la máquina virtual pero solo hemos configurado la imagen (de Ubuntu 18.04) que queríamos. 

!!! Note "Ejercicio"
    Examina las propiedades que tiene por defecto la máquina virtual:

     1. Número de procesadores (esto puedes verlo mirando en Virtualbox)
     2. RAM (puedes verlo en Virtualbox)
     3. Capacidad (disco duro, puedes verlo en Virtualbox).
     4. Tipo de adaptador de red (red interna, NAT, puente...)
     5. Nombre de la máquina en Virtualbox
     6. Nombre de la máquina dentro del sistema GNU/Linux (esto es lo único que estoy preguntando que no depende de Virtualbox, tienes que mirarlo accediendo a la máquina virtual).
    
    Trata de responder a todas estas preguntas.

Bien, **todas estas propiedades son configurables** y se configuran desde el Vagrantfile (lo veremos pronto).

### Destrucción de la máquina virtual
Ya no queremos la máquina anterior para nada así que ahora que la hemos apagado vamos también a eliminarla. Para eliminar la máquina virtual haz lo siguiente:

```
vagrant destroy -f
```

Además, elimina la carpeta ".vagrant".

![Eliminando la carpeta .vagrant](files/images/vagrant_directory_dotvagrant.png)

!!! Note "Ejercicio"
    Destruye la máquina virtual creada.

## Vagrant boxes
Antes hemos utilizado como "box" (como imagen de máquina virtual) la que nos viene en la documentación oficial de Vagrant en el [*getting started*](https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-project-setup).

Pero, ¿y si queremos crear máquinas con otras versiones de Ubuntu distintas a la 18.04 o queremos instalar otros sistemas operativos (p. ej: Almalinux, Debian, RHEL, Fedora, OpenSuse...)?

Bien, pues existe una [lista de boxes de Vagrant listas para usarse](https://portal.cloud.hashicorp.com/vagrant/discover).

Si entras al enlace verás que las boxes están definidas en un formato "usuario/máquina". Es más fiable utilizar máquinas oficiales y, por ello, si queremos una máquina de Ubuntu iremos mejor al usuario "Ubuntu" y la buscaremos.

!!! Ejercicio
    1. Busca una máquina con Ubuntu 22.04 (o superior) del usuario "Ubuntu". Ojo! No te será tan fácil y vas a tener que buscarte la vida para descubrir cuál es la máquina 22.04 ya que no vienen las versiones de la máquina si no "el nombre" que recibe la versión. Utiliza Google para descubrir cuál de las disponibles es la 22.04 (o una superior a esa, pero que sea del usuario Ubuntu). 
    2. Una vez descubras la máquina que quieras, crea una carpeta **"1-ubuntu22"** (al lado de la anterior **"0-probando-vagrant"**) y crea un Vagrantfile como el anterior pero ahora con el box de Ubuntu 22.04. Después:

        - Arranca la máquina.
        - Conéctate a ella con vagrant ssh
        - Comprueba que el sistema operativo instalado es Ubuntu 22.04. Esto puedes hacerlo con el comando: "lsb_release -a"
        - Crea una carpeta con tu nombre y apellidos en la máquina.
        - Sal de la máquina.
        - Apaga la máquina
        - Destruye totalmente la máquina (usa el comando y borra la carpeta .vagrant después).



## Configurando la máquina virtual
La configuración de la máquina virtual se hace desde el Vagrantfile (antes se ha puesto en un ejercicio el comprobar cuáles eran las propiedades que tenía por defecto). Vamos a crear una máquina virtual y configurar alguna cosa más.

A continuación se muestra un Vagrantfile algo más completo que los anteriores:
```rb
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  
  config.vm.provider :virtualbox do |vb|
    vb.name = "2-configuracion-basica"
  end
  
  config.vm.boot_timeout = 1000
end
```

En este Vagrantfile se configura lo siguiente:

1. Usar como imagen "ubuntu/jammy64".
2. Se configura que el arranque pueda durar hasta 1000 segundos antes de fallar (por defecto se corta a los 300 segundos -> 5 minutos).
3. Se indican las configuraciones de virtualbox dentro de la parte "config.vm.provider :virtualbox". Dentro solo hemos configurado una cosa, ¿qué crees que es?

!!! Note "Ejercicio"
    1. Crea la carpeta 2-configuracion-basica y copia el anterior Vagrantfile (algo más completo que los primeros que vimos).
    2. Una vez lo tengas asegúrate de que funciona (vagrant validate).
    3. Ahora arranca la máquina y comprueba si no da errores.
    4. Una vez funcione, **apaga la máquina y modifica el Vagrantfile** para intentar conseguir lo siguiente:
        - **Cambiar el nombre del equipo (puedes buscar en internet el comando para saber cuál es) a rivendell** (no lo confundas con vb.name, eso es el nombre de la máquina en Virtualbox, no el nombre del equipo en Linux).
        - **Conseguir que se te abra la interfaz gráfica de la máquina virtual (GUI) al arrancar la máquina.** Esto se hace dentro de la parte de provider, ya que forma parte de Virtualbox.
        - Hacer que la máquina use dos procesadores en lugar de uno (esto es dentro de la parte del provider)

Recuerda, por lógica, si quieres cambiar número de procesadores, ram u otras cosas que se hacen en Virtualbox, tienes que hacerlo en la parte del Vagrantfile relacionada con Virtualbox (dentro de la parte de provider :virtualbox). Si lo que quieres cambiar es algo relacionado con la configuración de la propia máquina Linux, lo haces fuera.

Intenta realizar el ejercicio anterior y levantar la máquina. Puedes ayudarte de [la documentación oficial](https://developer.hashicorp.com/vagrant/docs/vagrantfile/machine_settings), búsquedas en Google y ChatGPT (no te compliques demasiado, el ejercicio son sentencias de código bastante simples dentro del Vagrantfile, basicamente cada ejercicio es una línea).

## Aprovisionamiento mediante scripts
El aprovisionamiento se trata de darle a la máquina virtual una serie de tareas que se ejecuten automáticamente una vez arrancada. Vamos a empezar con una tarea muy simple: **queremos que al arrancar la máquina por primera vez se cree un fichero con una línea.**

!!! Note "Ejercicio: aprovisionamiento básico usando scripts"
    Destruye la máquina "2-configuracion-basica" (importante que lo hagas). Luego modifica el Vagrantfile de "2-configuracion-basica" para que ejecute la siguiente línea al arrancar la máquina (pon tu nombre y apellidos): 
    
    echo "Hola, me llamo X Y Z." >> /home/vagrant/texto.txt
    
    Una vez hecho esto arranca la máquina y verifica que se ha creado el fichero con una línea con tu nombre y apellidos.

En este caso voy a dejar que os busqueis un poco la vida. Para hacer este ejercicio utiliza la [documentación oficial](https://developer.hashicorp.com/vagrant/docs/provisioning/shell#inline-scripts) en la parte de "inline Scripts". 

??? Tip "Consejo"
    También puedes ayudarte de internet y herramientas de IA sin problema (eso sí, asegúrate de aprender y no solo de hacer lo que la IA te dice, la IA bien usada es genial pero mal usada solo te lastra). 
    
    Interactúa con ChatGPT o cualquier otra IA de manera que, si hay partes que te cuenta que no entiendes, le puedes decir que te especifique más, pregúntale por qué algo es como es, dile que algo te funciona pero no entiendes por qué, etc.

    Si utilizas las IAs para hacer las cosas rápido en lugar de para aprender las estás usando mal.

## Referencias
- Vagrant quickstart (documentación oficial de Vagrant). Obtenido de: https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-project-setup