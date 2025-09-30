# Docker
Docker es una herramienta de código abierto para desarrollar, distribuir y desplegar aplicaciones en entornos aislados denominados **contenedores**. Los **contenedores** son livianos, ya que, al contrario que las máquinas virtuales, se ejecutan dentro del núcleo de la máquina host.

## Instalación
Seguimos los pasos indicados en la [documentación oficial para Ubuntu](https://docs.docker.com/engine/install/ubuntu/) que detallamos a continuación:

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Añadimos el repositorio al sources.list de apt
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Instalamos Docker
 sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Probamos Docker
sudo docker run hello-world

# Comprobamos que nuestro usuario esté en el grupo de Docker
groups $USER
```

En caso de que el usuario no estuviese en el grupo de docker (en muchas otras distribuciones no se insertará en el grupo automáticamente) habría que añadirlo con:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

Las dos líneas anteriores nos permiten ejecutar Docker sin permisos de administrador.

Finalmente, comprobamos que el comando funciona correctamente:
```bash
docker version
docker info

# Verificamos que todo funciona instanciando un contenedor con la imagen "hello-world"
sudo docker run hello-world
```

## Imágenes
En Docker existen conceptos de: imágenes, contenedores, redes, volúmenes... Cada uno de estos conceptos se puede manejar con el comando correspondiente de `docker image|container|network|volume`.

Podemos gestionar las imágenes con el comando: **docker image ÓRDENES.**

```bash
docker image --help
```

### Descargar una imagen del repositorio oficial (DockerHub)
```bash
docker image pull nginx
```

Aunque recomiendo usar la anterior forma por ser mas clara y mejor para aprender, podrías abreviarlo también con:
```bash
docker pull nginx
```

Observa como se descarga la imagen (si te fijas, va completando pasos). Estos pasos que va completando son capas de la imagen que va descargando. En Docker estas capas se pueden reutilizar y de esta manera se ocupa menos espacio y todo funciona mucho más rápidamente.

!!! Nota
    Escribir **docker pull nginx** es equivalente a poner **docker pull nginx:latest** (esto es, si no ponemos nada después de los dos puntos siempre pondrá "latest" que es la versión que se descargará por defecto. Aunque el texto dice "latest", esta no tiene por qué ser la última (es más bien como la versión por defecto que descarga).

### Descargar una imagen del repositorio oficial (DockerHub) indicando versión concreta
Vamos a descargar una versión concreta. Se puede hacer con:
```bash
docker image pull nginx:1.27.5
```

Muchos proveedores suelen proporcionar imágenes pequeñas y muy ligeras denominadas **alpine**.

!!! Ejercicio
    Descarga las versiones 1.25 y “alpine” de nginx.

### Listar imágenes
Para listar imágenes seguimos el mismo patrón anterior, pero ahora añadimos **ls**:
```bash
docker image ls # Recomendado

docker images # más corto
```

!!! Ejercicio
    Observa las imágenes que aparecen y di si crees que son todas diferentes o hay alguna igual que otra.

### Eliminar imágenes

```bash
docker image rm <id_imagen>  # recomendado
docker rmi <id_imagen>       # más corto
```

Para los ids, no es necesario que los escribas completos (basta con los primeros dígitos). Para ver la id de la imagen que quieres borrar puedes usar `docker image ls`

!!! Ejercicio
    - Elimina la versión 1.25 de nginx.
    - Intenta eliminar la imagen de hello-world y observa que ocurre. Si no te deja no te preocupes, es porque hay un contenedor en ejecución. Lo eliminaremos más adelante (primero entendamos como funcionan los contenedores).

## Contenedores
Un contenedor es una instancia de una imagen. Al igual que en programación orientada a objetos un objeto es una instancia de una clase o similar a AWS, donde para crear una máquina virtual en EC2 seleccionamos una AMI (**A**mazon **M**achine **Image** de Ubuntu, Debian, Amazon Linux…) y se instancia una máquina virtual en base a esa imagen AMI.

Revisamos las opciones relacionadas con contenedores en Docker:

```bash
docker container --help
```

Las opciones más interesantes aquí son: **run**, **ls**, **stop** y **rm**. Empezaremos viendo como listarlos.

### Ver la lista de contenedores
```
# Muestra los contenedores en ejecución
docker container ls

# Muestra TODOS los contenedores
docker ls -a
```

!!! Ejercicio
    Usa los comandos anteriores para ver la lista de contenedores en ejecución y totales.

### Crear un contenedor
Como decíamos, los contenedores son **instancias de las imágenes**. Para crear un contenedor podemos usar la palabra clave **create** (solo lo crea) o **run** (lo crea y lo ejecuta). Usar **run** es lo más habitual, empezamos!

```bash
# Descargamos primero la imagen de nginx (o nginx:latest), es lo mismo
docker image pull nginx

# Ahora, creamos un contenedor a partir de la imagen
docker container run nginx
```

El **contenedor se ejecuta, pero tenemos un par de problemas**:

1. El terminal se nos queda permanentemente en espera mostrando los logs de nginx. No podemos escribir nada.
2. ¿Cómo accedemos a la web por defecto del nginx (al index.html)? No tenemos la ip de la máquina.

Bien, vamos a ir mejorando el comando para solucionar estos problemas uno por uno. Pulsamos **control + C** para parar la ejecución.

#### Crear un contenedor en segundo plano
Para que el contenedor se cree en segundo plano podemos usar la opción **-d (dettach)**.
```bash
docker container run -d nginx
```

Hemos ejecutado el contenedor, pero seguimos teniendo el problema de que **no sabemos cómo acceder a él**. No tenemos la IP del contenedor para ponerla en el navegador web y ver la página web por defecto de nginx. 

#### Crear un contenedor en segundo plano y acceder
Bien, le vamos a añadir a la opción **-d** una redirección de puertos. De esta manera, redirigiremos el puerto por defecto de nginx (80) al 8080 de nuestra máquina host.
```bash
docker container run -d -p 8080:80 nginx
```

Esto debería ejecutar un nginx (versión latest), en modo dettached (-d) y redirigiendo el puerto 80 del contenedor al 8080 de nuestra máquina.

!!! Ejercicio
    - Accede a tu navegador web y, en la barra de direcciones, accede al nginx. Piensa como hacerlo según lo que te acabo de explicar. Deberías ver la página por defecto de nginx.

### Parar contenedores
Hemos ejecutado ya múltiples contenedores con `docker container run`. Recuerda lo que hacía este comando: **crea el contenedor y lo ejecuta**. Esto significa que tenemos creados (y **en ejecución** varios contenedores).

Para parar los contenedores que tenemos en ejecución:
```bash
docker stop <id_contenedor>
```

Antes de eso, tendrás que listar los contenedores en ejecución para ver su id.

!!! Ejercicio
    1. Lista los contenedores en ejecución.
    2. Para todos los contenedores en ejecución excepto el nginx que tenemos funcionando bien (ese déjalo ejecutando).

### Eliminar contenedores
Puedes eliminar un contenedor de la siguiente manera:
```bash
docker container rm <id_contenedor> # Te recomiendo esta forma para aprender

# Otra opción
docker rmi <id_contenedor>
```

No es necesario escribir toda la id del contenedor, basta con escribir solo los primeros dígitos. Por ejemplo: para el contenedor "bd84f91df8be" podemos hacer solo `docker container rm bd8`.

!!! Ejercicio
    1. Lista los contenedores que tienes creados (todos).
    2. Eliminalos uno por uno (un comando por contenedor). Puede que alguno falle, no te preocupes por eso pero **lee el mensaje de error y piensa en por qué falla**.
    3. ¿Sabes por qué alguno ha fallado? Bien, es porque si está en ejecución debes pararlo antes (stop). Para todos los contenedores en ejecución y elimína todos los contenedores (que no quede ninguno).

## Repositorios de imágenes
El principal repositorio de imágenes de Docker es [**Dockerhub**](https://hub.docker.com/).

!!! Ejercicio
    1. Entra en Dockerhub y busca **nginx**. Mira qué versiones hay y la documentación de la imagen.

Si te fijas, al buscar algo en el repositorio vemos dos formatos de imágenes:

- En el primero solo aparece **nginx**. Esto es un repositorio oficial de la gente de Docker.
- En los siguientes aparece el formato **usuario / imagen**. En este caso, es el usuario **NGINX INc.** (el oficial de Nginx) el que ha creado las imágenes.

Las imágenes de Dockerhub, salvo un puñado que son mantenidas por la gente de DockerHub, siempre siguen el patrón usuario / imagen. Cualquier usuario puede subir sus imágenes a Dockerhub.

!!! Ejercicio
    1. Busca en Dockerhub "supermario" y ordena los resultados por número de descargas de la imagen.
    2. Desde línea de comandos, descarga la imagen y crea un contenedor tal y como hemos visto para abrir el juego desde el navegador web.


??? success "Ver solución"
    Podríamos simplemente ejecutar el docker run y, si la imagen no se encuentra en nuestro equipo, el propio docker se encargará de buscar la imagen y descargarla por nosotros. En este caso, vamos a seguir los pasos que hemos aprendido y descargar nosotros la imagen manualmente con `docker pull` y después crear el contenedor con `docker container run`.

    ```bash
    # Descargamos la imagen
    docker pull bharathshetty4/supermario

    # Creamos el contenedor mapeando el puerto 8080 de la máquina a nuestro 8600
    # porque así lo indica la documentación de la imagen en Dockerhub
    docker container run -d -p 8600:8080 bharathshetty4/supermario
    ```

    Finalmente, entramos en **http://localhost:8600** para jugar. Destacar que, aunque nosotros hemos utilizado el puerto 8600 de nuestro equipo podríamos haberlo hecho a cualquier otro puerto libre (por ejemplo, nuestro 8080 también, el 8000 u otro que queramos).

## Logs en Docker
Para revisar los logs relacionados con un contenedor puedes usar el siguiente comando:
```bash
docker container logs <id_contenedor|nombre_contenedor>
```

## Repaso y ampliación de lo visto hasta ahora
Estos ejercicios se basan en lo visto hasta ahora, pero añaden pequeños matices que tendrás que investigar:

!!! Ejercicios
    1. Crea un contenedor que levante nginx y lo enlace al puerto 8081 de nuestro host. Esto ya hemos visto como se hace, **pero esta vez el contenedor debe tener un nombre definido (debes darle un nombre al contenedor)**. Para ver como hacer esto usa la ayuda: `docker container run --help` (ahí verás como poner nombre al contenedor). El resto es como hemos hecho hasta ahora.
    2. Crea y ejecuta un contenedor con la última imagen de [MySQL](https://hub.docker.com/_/mysql) y con nombre "base_de_datos". Al crear el contenedor, es posible que este se pare solo (verifica que está en ejecución con `docker container ps`). Si se para solo, pista: revisa bien la documentación que se indica en DockerHub (pista: quizá tengas que crear alguna variable de entorno para establecerle una contraseña a MySQL) y comprueba los logs del contenedor (tal y como indicamos antes). Saca tus conclusiones e intenta arrreglar el problema.

Los ejercicios anteriores añaden complejidad a lo que llevamos hecho hasta ahora. Mientras que habíamos solo usado imágenes sencillas, existen otras que requieren un poco (o mucho) más de trabajo de configuración. Por ejemplo, si revisamos la [documentación de MySQL](https://hub.docker.com/_/mysql) podemos ver múltiples variables de entorno disponibles para su configuración.

Vamos a crear un contenedor sencillo de MySQL:

```bash
# En el ejercicio hemos creado un contenedor (en el que probablemente falló la ejecución)
# Vamos a comprobar si sigue existiendo
docker container ls -a

# En mi caso existe, pero no funciona porque no le había puesto variable de entorno. Borro el contenedor.
docker container rm base_de_datos # o docker container rm 25b (por id)

# Creamos (de nuevo) un contenedor con MySQL. Mapeamos con nuestro puerto 33060 y contraseña abc123
docker container run -dp 33060:3306 --name base_de_datos -e MYSQL_ROOT_PASSWORD=abc123 mysql

# Comprobamos que el contenedor se ha ejecutado correctamente
docker container ls

# Si hay cualquier problema siempre comprobamos logs
docker container logs base_de_datos
```

Si todo fue bien, probamos a conectarnos desde nuestro equipo con MySQL Workbench, DBeaver u otro cliente del que dispongamos. Debería funcionar correctamente.

!!! Ejercicio
      1. Crea un contenedor de MySQL que genere una contraseña aleatoria (y logueate en él).
      2. Crea un contenedor de MySQL que permita contraseña vacía para el usuario root (y logueate en él).
      3. Borra los dos contenedores anteriores.

## Interactuar con los contenedores
Si revisamos la documentación de nuevo con `docker container exec --help` podemos ver una gran serie de opciones. Vamos a fijarnos proximamente en las siguientes:

```
Usage:  docker container exec [OPTIONS] CONTAINER COMMAND [ARG...]

Execute a command in a running container

Aliases:
  docker container exec, docker exec

Options:
  -d, --detach               Detached mode: run command in the background
      --detach-keys string   Override the key sequence for detaching a container
  -e, --env list             Set environment variables
      --env-file list        Read in a file of environment variables
  -i, --interactive          Keep STDIN open even if not attached
      --privileged           Give extended privileges to the command
  -t, --tty                  Allocate a pseudo-TTY
  -u, --user string          Username or UID (format: "<name|uid>[:<group|gid>]")
  -w, --workdir string       Working directory inside the container
```

Por otro lado, podemos conectarnos inmediatamente al crear un contenedor nuevo. Si probamos con `docker container run --help` vemos que se repiten el -i y el -t.
```
Options:
  -i, --interactive                      Keep STDIN open even if not attached
  -t, --tty                              Allocate a pseudo-TTY
  -v, --volume list                      Bind mount a volume
```

En principio, para interactuar con contenedores usaremos **-i** y **-t**. Cuando queramos conectarnos por terminal al contenedor podemos usar esas dos opciones, y lo podemos hacer directamente en el run. Con `docker container run -it` podemos crear un nuevo contenedor, ejecutarlo y directamente conetarnos a él (ejecutar bash). Al salir del contenedor también lo paramos (ya que no estamos en modo -d: dettach).

### Conectarse a un contenedor en ejecución
Empecemos por conectarnos a un contenedor existente:
```bash
# Ejecutamos un ls en el contenedor de mysql para ver que hay
docker container exec -it base_de_datos ls

# Ejecutamos un cat para ver el fichero de configuracion de mysql
docker container exec -it base_de_datos cat /etc/my.cnf

# Creamos un fichero /hola.txt
docker container exec -it base_de_datos touch hola.txt

# Ahora lo mas interesante: ejecutamos un interprete de BASH
docker container exec -it base_de_datos bash
```

Voilá! con este último comando hemos abierto un terminal de bash en el contenedor. Ahora podemos hacer lo que queramos ahí dentro. Puedes hacer un `ls` y un `pwd` y comprobar que se creó el fichero "hola.txt".

Para salir solo tenemos que hacerlo como en cualquier terminal, con `exit`.

### Crear, ejecutar y conectarse a un contenedor
Vamos a hacer lo mismo, pero ahora nos conectamos directamente al contenedor al crearlo:

```bash
# Creamos y ejecutamos un contenedor de ubuntu y el comando ls en él
docker container run -p 33061:3306 -it ubuntu bash
```
Esto debería abrirnos un terminal dentro de la máquina Ubuntu. Como no entramos en modo -d (dettach), el contenedor se va a parar cuando salgamos.

!!! Ejercicios
    1. Ejecuta el comando anterior. Desde dentro de la máquina, mira los archivos que hay en el directorio actual (`ls`).
    2. Comprueba tu ip.
    3. ¿Puedes hacerte un ping, por ejemplo, a ti mismo?.
   
    !!! abstract "Nota"
        Supongo que has tenido dificultades con estos tres ejercicios. Esto es porque los contenedores son muy livianos y apenas traen utilidades. No existe ni ifconfig, ni ip address ni ping. La única manera de mirar la ip es viéndolo en el fichero de configuración correspondiente.

        Vamos a continuar practicando.

    4. Crea y ejecuta un contenedor de nginx:latest y abre un shell en él, todo en el mismo comando.
    5. Prueba el comando curl a localhost, si no está instalado instalalo. Finalmente, sal (exit).
    6. Después de salir, ¿el contenedor sigue en ejecucióno? ¿Sigue existiendo? Si aún existe, elimina el contenedor.
    7. Después de eliminarlo, vuelve a ejecutar el comando del punto 4 pero esta vez añádele la opción **-rm**. Sal del contenedor e intenta adivinar que hizo el --rm (pista: mira la lista de contenedores de nuevo).
    8. Ahora, busca en DockerHub "alpine", esta es una distribución muy minimalista,.
    9.  Descarga la imagen de alpine. Revisa la lista de imágenes para verificar que está descargada. ¿Cuánto ocupa?
    10. Ahora, intenta crear un contenedor de alpine abriendo un bash en él, ¿qué ocurre?
    11. Como ves, la imagen es muy pequeña y ni siquiera tiene disponible bash. Inténtalo de nuevo con un shell mucho más antiguo (sh).
    12. Debería funcionarte. Ahora, sal de la máquina (dejará de estar en ejecución cuando salgas). Luego, arráncala de nuevo (ojo, no es con `docker run`).
    13. Abre un shell en el contenedor.
    14. Juega un poco con este gestor de paquetes (hasta ahora probablemente conozcas **apt** y quizás **yum** y **dnf**). Utiliza el comando `apk --help` para intentar actualizar los paquetes e instalar bash. Después sal del contenedor.
    15. Sal del contenedor y páralo.
    16. Arranca el contenedor de nuevo abriendo un terminal en él. Todo en el mismo comando (es decir, sin usar docker exec). Pista: al usar `docker start` no es con -it, usa `docker start --help` para la ayuda (tampoco necesitarás poner explicitamente el intérprete de comandos, bash o sh, a usar).

??? success "Ver solución"
    ```bash
    # 1. Miramos los archivos de la máquina y hacemos un ls
    docker container run -p 33061:3306 -it ubuntu bash
    ls

    # 2. Comprobamos nuestra ip
    ip address # no está instalado
    ifconfig # no funcionará, net-tools no está instalado

    # Ya que parece que no tenemos software instalado, la información persistente suele estar en ficheros
    # Vamos a ver qué ficheros hay en /etc que pueden tener nuestra información de conexión
    ls /etc/  # Pueden ser interesantes host.conf, networks, hosts, hostname.

    # Comprobamos el fichero hosts y ahí está nuestra ip
    cat /etc/hosts

    # Otra manera: instalando iproute2 (comandos ip)
    apt update
    apt install iproute2

    # 3. No se puede, ping no está instalado, si queremos hacerlo funcionar:
    apt install -y iputils-ping
    ping localhost              # ya funciona

    # 4. Crear un contenedor nginx y abrir un shell en 1 solo comando    
    docker container run -it nginx bash

    # Podriamos mapear puertos con -p si queremos acceder por web al nginx (no se pide ni indica)
    docker container run -it -p 8080:80 nginx bash

    # 5. Probamos "curl localhost". Si curl no está instalado, lo instalamos
    apt update
    apt install curl
    curl localhost
    exit

    # 6. Miramos si el contenedor está creado y en ejecución y si existe lo eliminamos
    docker container ls     # No está en ejecución
    docker container ls -a  # Sigue creado

    docker container rm 7aa # o tu id de contenedor o nombre, si estuviese en ejecución habría que hacer antes docker stop

    # 7. Ejecutamos lo mismo pero con opción --rm
    docker container run -it --rm nginx bash
    
    # Salimos del shell
    exit

    # Comprobamos si está el contenedor
    docker container ls -a  # El contenedor no está, la opción --rm lo borra al salir

    # 8. Buscar alpine en Dockerhub y descargarla. Ver las imágenes
    docker pull alpine

    # 9. Miramos que está descargada y ocupa entre 7 y 8mbs
    docker image ls

    # 10. Creamos un contenedor de alpine y abrimos un intérprete de bash
    docker container run -it alpine bash    # ERROR, bash no se encuentra en la variable PATH

    # 11. Intentamos crearlo y conectarnos con un intérprete sh
    docker container run -it alpine sh    # Funciona!

    # 12. Salimos y arrancamos de nuevo el contenedor
    exit
    docker container ls -a  # Miramos la id del contenedor para arrancarlo nuevamente (en mi caso es 5488588662e6)
    docker container start 5488588662e6

    # 13. Abrimos sh en el contenedor
    docker exec -it 5488588662e6 sh

    # 14. Exploramos las opciones del gestor de paquetes de alpine, apk
    apk --help
    apk update              # Actualizamos la lista de paquetes
    apk add bash            # Instalamos bash
  
    # 15. Salir del contenedor y pararlo
    exit
    docker stop 548
    docker start --help     # Esta vez no es con -it, sino con -ai (y no ponemos el intérprete al final)
    docker start -ai 548
    ```

## Creación de volúmenes
Hace un rato creamos contenedores para MySQL. El problema es que, **si eliminamos el contenedor y lo volvemos a crear, los datos de las bases de datos almacenadas se pierden**. Los **volúmenes** nos permiten **almacenar datos de forma persistente** e incluso compartirlos entre distintos contenedores.

Primero, para crear y listar volúmenes:

```bash
# Crea un volumen (aunque no es necesario ya que cuando lo asignes, si no existe, se creará igualmente)
docker volume create datos-mysql

# Lista los volúmenes
docker volume ls

# Ver la información del volumen
docker volume inspect datos-mysql
```

Aunque se pueden crear volúmenes con `docker volume create`, no es necesario hacerlo antes de asignarlo (ya que al intentar asignarlo, si no existe, se crea). **Vamos a ver como es la sintaxis para asignar el volumen a contenedores**. Hay varias sintaxis posibles:
```bash
docker run --mount type=volume,src=nombre_volumen,dst=ruta_contenedor
o
docker run --volume nombre_volumen:ruta_contenedor
o
docker run -v nombre_volumen:ruta_contenedor
```

Vamos a probar a crear un [contenedor de MySQL con un volumen asignado](https://hub.docker.com/_/mysql):
```bash
docker run --mount type=volume,src=datos-mysql,dst=/var/lib/mysql # (1)!
```

1. La ruta `/var/lib/mysql` es donde MySQL guarda los datos.

Recomiendo consultar más información sobre esto en la [documentación oficial de volúmenes de Docker](https://docs.docker.com/engine/storage/volumes/).

También, si quieres ver información sobre un volumen puedes usar `docker inspect <id_volumen|nombre_volumen>`.

!!! Note "Ejercicio (reto)"
    Como en los anteriores, intenta hacer el ejercicio antes de mirar la solución:
    
    1. Intenta, con la información anterior, crear un contenedor nuevo de MySQL de nombre "mysql-with-volume" con un volumen datos-mysql en /var/lib/mysql y conéctala con un puerto de tu máquina host. Verifica desde tu cliente de MySQL que puedes conectarte al contenedor.
    2. Abre un shell de bash en el contenedor.
    3. Ejecuta MySQL y crea una base de datos "pruebas" con una tabla usuarios con un id y un nombre. Inserta un usuario.
    4. Verifica desde tu cliente de MySQL del host que se ha insertado el usuario. Después, sal del contenedor, páralo y elimínalo.
    5. Usa `docker volume --help`. Luego, guiándote por la ayuda, lista los volúmenes existentes (verás que el que has usado todavía está).
    6. Crea de nuevo un contenedor de MySQL de la misma manera, que use el mismo volumen. Comprueba que aún están los datos dentro usando SOLO UN COMANDO DE DOCKER EXEC: solo que ahora, **en lugar de ejecutar bash, ejecutarás `mysql -u root -p...`**
    7. Elimina completamente el contenedor sin pararlo antes (sin usar docker stop). Para ello solo tienes que añadir -f para forzar y así no tendrás que pararlo para eliminarlo.
    8. Mira si el volumen aún existe y, si existe, mira su información (el comando está un poco más arriba puesto). Verás que aún existe a pesar de que hemos eliminado el contenedor. Mira donde se guarda esa información en tu máquina host y haz un ls de la ubicación (puede que tengas que usar sudo).

??? success "Ver solución"
    ```bash
    # 1. Creamos el contenedor
    docker run -d -p 3336:3306 --name mysql-with-volume --mount type=volume,src=datos-mysql,dst=/var/lib/mysql -e MYSQL_ROOT_PASSWORD=abc123 mysql

    # Verificamos que está en ejecución (si está en ejecución todo va bien)
    docker ls

    # 2. Ejecutamos bash
    docker exec -it mysql-with-volume bash

    # 3. Ejecutamos las consultas (lo hago en una línea, pero podrías hacerlo de forma interactiva)
    mysql -u root -pabc123 -e "CREATE DATABASE IF NOT EXISTS pruebas;CREATE TABLE IF NOT EXISTS pruebas.usuarios (id int not null primary key auto_increment, nombre varchar(255) not null);INSERT INTO pruebas.usuarios (nombre) VALUES ('Linus Torvalds')";

    # 4. Salimos, paramos y eliminamos el contenedor
    docker container stop mysql-with-volume
    docker container rm mysql-with-volume

    # 5. Usamos la ayuda de docker volume y listamos los volúmenes
    docker volume --help
    docker volume ls

    # 6. Creamos de nuevo el contenedor. Comprobamos que aún están los datos con un comando de docker exec
    docker container run -d -p 3336:3306 --name mysql-with-volume --mount type=volume,src=datos-mysql,dst=/var/lib/mysql -e MYSQL_ROOT_PASSWORD=abc123 mysql
    docker exec -it mysql-with-volume mysql -u root -pabc123 -e "SELECT * FROM pruebas.usuarios;"

    # 7. Eliminamos el contenedor sin pararlo antes
    docker container rm -f mysql-with-volume

    # 8. Comprobamos si aún existe el volumen y vemos su información con docker inspect. Intentamos hacer ls de la ubicación.
    docker volume inspect datos-mysql
    sudo ls /var/lib/docker/volumes/datos-mysql/_data

    # 9. Elimina el volumen
    docker volume rm datos-mysql
    ```

## Creación de puntos de montaje (bind mounts)
Los **bind mounts** o **puntos de montaje** son similares a lo anterior (incluso su sintaxis es muy parecida). La diferencia radica en que en el caso anterior asignamos el volumen con **nombre del volumen** y **ruta en el contenedor**. En el caso de los bind mounts enlazamos **ruta en el host** con **ruta en el contenedor**:

```bash
docker run --mount type=bind,src=ruta_host,dst=ruta_contenedor
o
docker run --volume ruta_host:ruta_contenedor
o
docker run -v ruta_host:ruta_contenedor```
```

La sintaxis es igual, pero ahora en lugar de `type=volume` usamos `type=bind`. En el caso de las 2 últimas sintaxis con --volume o -v, simplemente ponemos una ruta absoluta en lugar del nombre del volumen.

A continuación se muestra la **diferencia entre volúmenes** (nombre:ruta_contenedor) **y puntos de montaje** (ruta_host:ruta_contenedor):

=== "VOLUMEN"

    ```bash
    docker run --mount type=volume,src=nombre_volumen,dst=ruta_contenedor
    o
    docker run --volume nombre_volumen:ruta_contenedor
    o
    docker run -v nombre_volumen:ruta_contenedor
    ```

=== "PUNTO DE MONTAJE"

    ```bash
    docker run --mount type=bind,src=ruta_host,dst=ruta_contenedor
    o
    docker run --volume ruta_host:ruta_contenedor
    o
    docker run -v ruta_host:ruta_contenedor```
    ```

!!! tip "Información adicional"
    - Los volúmenes se usan para almacenar datos en los que no te importan donde estén en tu máquina host (de hecho, **se almacenarán siempre, como ya has visto en `/var/lib/docker/volumes/`**). Por ejemplo: almacenar bases de datos.
    - Los puntos de montaje, por su parte, se sincronizan con una carpeta que tengas en el host. Servirán, por ejemplo, para compartir código que estás editando y que aparezca directamente en una carpeta del contenedor. De esta manera podrás actualizarlo.

!!! Ejercicio
    1. Busca en Dockerhub una imagen que tenga un servidor web con PHP 8. Crea un fichero .php en él (puedes abrir un shell con `docker exec`) y entra en la página para ver que funciona.
    2. Crea una carpeta `mi-proyecto` con un fichero .php y abre la carpeta con Visual Studio Code. Luego, crea un contenedor con un punto de montaje (bind mount) de manera que cada vez que edites el código en local se actualice en el contenedor de docker (esto es, que se actualice la página en tu navegador).

## Inspeccionar objetos
Puedes usar `docker image|container|volume|network inspect` para ver información completa de todos estos objetos. Pruébalo con alguno que tengas creado.

## Redes en Docker
Existen varias redes predeterminadas en docker y es posible crear redes adicionales y eliminarlas:
```bash
# Miramos la ayuda de docker network
docker network --help

# Si queremos crear una red
docker network create mi-red

# Vemos la lista de redes (por defecto los contenedores que creamos sin asignar red están en la bridge)
docker network ls

# Vemos la información de la red mi-red y de la red bridge
docker network inspect mi-red
docker network inspect bridge

# Si quisiesemos crear un contenedor asignandolo a esa red
docker container run --network mi-red ...

# Para eliminar la red que hemos creado
docker network rm mi-red
```

### Red bridge
**Por defecto, todos los contenedores que creamos están en la red de tipo bridge** que vemos al hacer `docker network ls`. Esta red bridge está en el rango 172.17.0.0/16. Para exponer puertos desde esta red tenemos que usar la opción **-p** que hemos visto anteriormente.

Si inspeccionamos de un par de contenedores cualquiera que hayamos creado y a los que no hemos asignado ninguna red. Esto estarán en la red por defecto de tipo **bridge**:
```bash
docker container inspect base_de_datos
docker container inspect 54885
```

El resultado es el siguiente (quito parte de los pares clave-valor que no nos interesan):
=== "CONTENEDOR 1"

    ```
    ...
    "IPAddress": "172.17.0.2",
    "MacAddress": "b2:b2:4d:a6:fa:78",
    "Networks": {
        "bridge": {
            "NetworkID": "1962135f806ac8414eb317c30acb875d348ccf800f8c11b8e39c6707f366845f",
            "EndpointID": "d6ddd2aed3c982b1959d9c28bc89f760b6584a877b97d599dee85ab156995dd1",
            "Gateway": "172.17.0.1",
            "IPAddress": "172.17.0.2",
        }
    }
    ...
    ```

=== "CONTENEDOR 2"

    ```
    ...
    "IPAddress": "172.17.0.3",
    "MacAddress": "e6:b0:a0:b5:ab:50",
    "Networks": {
        "bridge": {
            "NetworkID": "1962135f806ac8414eb317c30acb875d348ccf800f8c11b8e39c6707f366845f",
            "EndpointID": "9b3caef753d319a7bfb2ee6cd31d94e90aa4ac1ffb9dc8b351eeeb7d7bb7a3e8",
            "Gateway": "172.17.0.1",
            "IPAddress": "172.17.0.3",
        }
    }
    ...
    ```

Podemos ver que la red de ambos es de tipo **bridge** y las IPs son **172.17.0.2** y **172.17.0.3**, por lo que **están en la misma red local**.

### Red host
Al hacer `docker network ls` vemos que hay tres redes que ya vienen creadas con docker: **bridge** (la hemos visto antes, es la default), **host** y **none**.

Si creamos un contenedor en la red host, podremos acceder a la web directamente desde localhost. Esto es, no tendrá ip propia y compartirá completamente la red de nuestra máquina.

!!! Note "Ejercicio"
    Crea un contenedor con Apache que use la red host (no tienes que usar -p, crea el contenedor más básico posible). Deberías poder acceder desde tu propia ip de host y el puerto predeterminado sin necesidad de redirigir puertos.

### Red none
La red none elimina eth0 y nos deja solo con localhost en el contenedor.


### Nuevas redes
```bash
docker network create mi-red
docker network ls

# Vemos la información de la red
docker network inspect mi-red

# Para la ayuda
docker network create --help
```

El comando `docker network create mi-red` nos ha creado una nueva red sencilla de tipo bridge en el rango 172.19.0.0/16 (puedes verlo en el `docker network inspect`).

Si queremos usar la red en un nuevo contenedor:
```bash
docker container run -d --name mi-nginx1 --network mi-red nginx
```

Si, en cambio, queremos conectar un contenedor ya existente a esta nueva red:
```bash
# Para conectar
docker network connect <id_red> <id_contenedor>

# Para desconectar
docker network disconnect <id_red> <id_contenedor>

```

!!! Note "Ejercicio"
    1. Conecta un contenedor cualquiera a la misma red que el que hemos creado. Verifícalo con `docker network inspect` y `docker container inspect`.
    2. Desconectalo con de la misma manera que lo has conectado y verifica que ya no aparece en la red al hacer el inspect.

Para producción no usaremos nunca la red por defecto. Siempre crearemos nuestras propias redes para las máquinas.

## Ejercicios
Prepara un fichero .md (markdown) para documentar estos ejercicios en formato tutorial (puedes usar VSCode con el plugin *Markdown all-in-one*). Usa siempre sentencias de código en lugar de imágenes.

1. Monta con Docker un Wordpress totalmente funcional (y configúralo entrando en localhost e introduciendo los datos que se pidan).
2. Cuando consigas completar el Wordpress, haz que los datos no se pierdan cuando eliminas los contenedores (usando un volumen).
3. Haz lo mismo pero ahora con un Drupal y MariaDB.