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

![alt text](image.png)

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

# Crear, ejecutar y conectarse a un contenedor
Vamos a hacer lo mismo, pero ahora nos conectamos directamente al contenedor al crearlo:

```bash
# Creamos y ejecutamos un contenedor de mysql y el comando ls en él
docker container run -p 33061:3306 -it ubuntu bash
```
Esto debería abrirnos un terminal dentro de la máquina Ubuntu. Como no entramos en modo -d (dettach), el contenedor se va a parar cuando salgamos.

!!! Ejercicio
    1. Desde la máquina, mira los archivos que hay en el directorio actual (`ls`).
    2. Comprueba tu ip.
    3. ¿Puedes hacerte un ping, por ejemplo, a ti mismo?

Bien, supongo que has tenido dificultades con los ejercicios. Esto es porque los contenedores son muy livianos y apenas traen utilidades. No existe ni ifconfig, ni ip address ni ping. La única manera de mirar la ip es viéndolo en el fichero de configuración correspondiente.

## Creación de volúmenes


## Crear redes



## Creación de puntos de montaje (bind mounts)

## Inspeccionar contenedores





