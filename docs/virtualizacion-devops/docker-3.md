# Docker Compose

## ¿Qué es y para qué sirve?
Docker compose es una herramienta para definir y ejecutar [aplicaciones multi-contenedor](https://docs.docker.com/compose/) en docker. En él, con un solo fichero **compose.yml** podemos levantar múltiples contenedores de forma centralizada y sencilla (con un solo comando, mucho más fácil que como hemos hecho hasta ahora).

La idea importante aquí es que **ya no describimos los contenedores con un comando larguísimo**, sino con un fichero declarativo. Es decir, en lugar de acordarnos de muchas opciones de `docker container run`, las dejamos escritas en un YAML para poder leerlas, modificarlas y reutilizarlas.

## Levantando un entorno PHP sin docker compose
**Si NO USAMOS docker compose podríamos montar un entorno simple con un único contenedor con PHP y Apache de la siguiente manera**:
```bash
# Levantar el contenedor de modo que la salida estandar esté ligada al terminal (no podríamos usar el terminal)
docker container run -p 8080:80 --name mi-php php:8.4-apache

# Otra opción (modo detached, podemos seguir usando el terminal)
docker container run -d -p 8080:80 --name mi-php php:8.4-apache   # Podemos poner -d -p o -dp

# Si queremos parar y eliminar el contenedor usamos:
docker container stop mi-php
docker container rm mi-php

# Si está parado y queremos arrancarlo de nuevo
docker container start mi-php
```

Esto es relativamente sencillo ahora, pero en el momento en que añadamos bases de datos, volúmenes, redes, bind-mounts y otros contenedores la cantidad de comandos se vuelve una completa tortura. Por esta razón, hay otra manera de montar contenedores mucho más sencilla: **declararlos en un fichero yaml**.

## Nombres del fichero de docker compose
Para crear contenedores con docker compose hay que crear un fichero de texto que debe llamarse de una de las siguientes maneras:

- compose.yaml
- compose.yml
- docker-compose.yaml
- docker-compose.yml

Al ejecutar el comando `docker compose up` automáticamente el demonio de docker buscará siempre uno de esos ficheros en el directorio actual. Si no lo hay, no funcionará.

## Primer caso práctico: montar un entorno básico con Apache2 y PHP

Veamos primero a crear un `index.php` sencillo:
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Página web con HTML y PHP</title>
</head>
<body>
    <h1>Mi página web</h1>
    <?php
        echo "<p>Hola mundo!</p>";
    ?>
</body>
</html>
```

Tenemos ese fichero que muestra un "Hello world" usando un `echo` de PHP. Vamos a ver como, **sin necesidad de instalar PHP en nuestro sistema, podemos dockerizar esta aplicación**.

Aquí podríamos haber empezado con una imagen de Linux "genérica" como Ubuntu, pero en ese caso todavía tendríamos que instalar Apache o PHP dentro del contenedor. Para estos primeros ejemplos **nos interesa reducir ruido** y centrarnos en entender Compose, los puertos y los puntos de montaje. Por eso usamos directamente `php:8.4-apache`, que ya trae lo necesario para servir una página PHP.

```yaml
services:
  mi-php:
    image: php:8.4-apache
    ports:
      - "8080:80"
```

Este es un **fichero de ejemplo de docker compose** que nos levanta un contenedor de PHP con Apache2 (**php:8.4-apache**). Veamos para qué sirve cada una de las etiquetas que hemos puesto:

- Etiqueta "services": Esta es siempre **la primera línea del yaml**. En todos los ficheros de docker compose la pondremos de primera.
    - Nombre del contenedor (en este caso: **mi-php**): a partir de aquí definiremos las propiedades del contenedor (mapeo de puertos, imagen en la que se basa, si se usan volúmenes o puntos de montaje, etc.).
        - Etiqueta **"image"**: indico la imagen que uso como base del contenedor. Equivalente a: docker container run --name mi-php **php:8.4-apache**.
        - Etiqueta **"ports"**: para mapear puertos. Equivalencia: docker container run --name mi-php **-p 8080:80** php:8.4-apache

Empezamos con el primer comando de **docker compose**: `docker compose config`.

```bash
# Comprueba si el YAML es válido y muestra la configuración final
docker compose config
```

Este comando no arranca contenedores. Lo que hace es **leer el compose.yml y enseñarte cómo lo interpreta Docker Compose**. Es muy útil para detectar errores de indentación, comprobar que los puertos están bien escritos o verificar el resultado final antes de levantar de verdad el contenedor con `docker compose up`.

!!! Note "Ejercicio (parte I)"

    1. Crea una carpeta ejemplo1-compose. Dentro, crea el fichero .php anterior y el compose.yml (ve escribiéndolo tu línea a línea para interiorizar el conocimiento, no hagas copy-paste).
    2. Una vez tienes los ficheros, sitúate en la carpeta desde el terminal y ejecuta el comando: `docker compose config`. Este comando te permitirá verificar que la configuración que has escrito es correcta.
    3. Revisa la salida que te muestra. Comprueba que aparece el servicio `mi-php` y que el mapeo de puertos es `8080:80`.
    4. Cambia (a propósito) el YAML para que no esté bien indentado (para ver que pasa si está mal). Luego, vuelve a lanzar `docker compose config` y observa el mensaje. Puede ayudarte a entender mejor el comando.
    5. Corrige de nuevo el yaml para que esté correcto y ejecuta `docker compose config`.
    6. Finalmente, si todo está correcto, levanta el contenedor con `docker compose up`. Esto levantará el contenedor (pruébalo y luego, para pararlo, haz control + C).

Con este ejercicio has realizado con un fichero yaml lo mismo que se ha hecho al principio del tutorial con `docker container run`. Es exactamente lo mismo, pero mucho más sencillo una vez la complejidad crece (ya que está todo en el yaml y solo tenemos que escribir un comando).

## Comandos básicos

Los siguientes comandos permiten levantar y tirar un contenedor:

```bash
# Levantar TODOS los contenedores declarados en el compose.yml
docker compose up

# Levantar TODOS los contenedores en modo detached (-d)
docker compose up -d

# Parar TODOS los contenedores que haya declarados en el compose.yml
docker compose stop

# Eliminar todos los contenedores
docker compose down

# Eliminar todos los contenedores (y sus volúmenes si están declarados)
docker compose down -v
```

Es **mucho más simple que cuando solo usábamos `docker run`**. Esto es, solo con hacer `docker compose up -d` podemos levantar uno (o muchos) contenedores y con `docker compose down` eliminarlos todos de un plumazo.

!!! Note "Ejercicio (parte II)"
    Si has hecho el primer ejercicio, ya deberías tener el index.php y el compose.yml escritos. Continuamos:
    
    1. Levanta el contenedor en modo *detached* (-d).
    2. Prueba si funciona la página web... ¿debería funcionar 🤔?. Fíjate en que el `index.php` todavía solo existe en tu carpeta del host: aún no hemos montado esa carpeta dentro del contenedor, así que puede que no te funcione todavía.

    Probablemente no te funcione la página o te de un error *403 forbidden*. Ahora la pregunta es, ¿por qué? ¿Debería enseñarnos el index que creamos? ¿Lo ve realmente Apache dentro del contenedor o falta algo más?

    Finalmente, **apaga el contenedor** (no soluciones el problema de código aún, lo haremos en la siguiente sección).

## Añadiendo puntos de montaje al contenedor
Ya sabemos cositas, pero aún no podemos subir nuestro código al contenedor!!! Vamos a ello, necesitamos un **punto de montaje**. 

### Punto de montaje con `docker run` (repaso)
Primero de todo, **vamos a recordar como lo hacíamos con `docker run`**:
```bash
# Sincronizamos la carpeta de mi proyecto, por ejemplo: /home/marcos/desarrollo/mi-php, con la /var/www/html del contenedor
docker container run --name mi-php -d -p 8080:80 -v /home/marcos/desarrollo/mi-php:/var/www/html php:8.4-apache
```

Como ves, este tipo de comandos se van complicando demasiado. En este comando hemos añadido el `bind-mount`, de manera que la carpeta "mi-php" donde tengo mis ficheros, la comparto con el document root de Apache (/var/www/html). De esta manera, edito mi código en Visual Studio Code y aparecerá directamente en el contenedor.

### Punto de montaje con `docker compose` (más sencillo)

La parte de `-v /home/marcos/desarrollo/mi-php:/var/www/html` añadida al compose.yml sería así:
```yml
services:
  mi-php:
    image: php:8.4-apache
    ports:
      - "8080:80"
    volumes:
      - ./:/var/www/html    # En este caso vamos a poner la ruta relativa (./ es el directorio actual)
```

Con esto todo lo que hay en mi directorio actual **se verá dentro del contenedor** en la carpeta `/var/www/html`.

Ten en cuenta que no se está copiando, en sentido estricto, lo que tenemos en nuestra carpeta al contenedor. Lo que hacemos es **montar** esa carpeta del host dentro del contenedor. Eso significa que, si editas un fichero en tu equipo, el cambio se ve inmediatamente dentro del contenedor, porque ambos están apuntando a los mismos archivos.

!!! Note "Ejercicio (parte 3)"
    1. Añade el volumen al contenedor del compose.yml.
    2. Tenemos que destruir el contenedor y crearlo de nuevo para que todo funcione. Mira los contenedores en ejecución con `docker container ls -a` y con `docker compose ls -a`.
    3. Destruye los contenedores con `docker compose... algo!`.
    4. Créalos de nuevo y prueba a acceder otra vez desde el navegador web. Debería aparecer la página.

## Accediendo a los contenedores

### Acceso a los contenedores con `docker container exec`
Podemos acceder a los contenedores con el comando habitual (`docker container exec`).

!!! Note "Ejercicio"
    1. ¿Cómo se llama el contenedor que se ha creado? ¿Qué patrón sigue el nombre?
    2. Accede al contenedor usando su nombre y lista los ficheros que hay en /var/www/html. ¿Cuáles son?

Como habrás visto, el contenedor sigue el patrón <nombre_carpeta>-<nombre_en_el_yaml>-<numero>. Por ejemplo: proyecto-php-mi-php-1. Usar este nombre es un poco "complicado" o enredoso, pero **docker compose también nos ayuda con esto**.

### Acceso a los contenedores con `docker compose exec`
Usando `docker compose --help` verás que también existe el parámetro **exec** (es decir, puedes hacer lo mismo con `docker compose exec` que has hecho con `docker container exec` pero ahora puedes usar el nombre `mi-php` que has definido en el yaml).

Un ejemplo típico sería:
```bash
docker compose exec mi-php bash
```

Si esa imagen no tuviese `bash`, en algunos contenedores podrías usar `sh`.

!!! Note "Ejercicio (acceso a contenedores)"
    1. Ejecuta `docker compose --help` y mira si hay la opción exec.
    2. Prueba de nuevo a abrir un terminal de bash en el contenedor pero ahora usando `docker compose exec`. Recuerda, con `docker compose exec` puedes usar directamente el nombre que has definido en el yaml.
    3. Lista de nuevo lo que hay en /var/www/html.
    4. Habrás visto que hay un fichero compose.yml en el directorio (lo cual no está muy bien). **Modifica tu fichero compose.yml para que el código de tu aplicación esté en una carpeta "src"**. La jerarquía debería quedar tal que así: 
          - ./compose.yml
          - ./src/
          - ./src/index.php
    
    Una vez has terminado con esto, deberías poder modificar tu código desde Visual Studio Code y esos cambios se reflejarán inmediatamente en la página web. Confírmalo.

## Añadido de más contenedores
En el fichero podemos añadir tantos contenedores como queramos. Para añadir un nuevo contenedor, simplemente tenemos que hacer lo siguiente:
```yml
services:
  mi-php:
    image: php:8.4-apache
    ports:
      - "8080:80"
    volumes:
      - ./:/var/www/html    # En este caso vamos a poner la ruta relativa (./ es el directorio actual)

  mi-bd:
# ... cosas
```

Bien, dentro de mi-bd, de nuevo puedes meter imagen, puertos, volúmenes, etc. Ya has hecho esto antes con docker, así que ahora lo haremos con docker compose. La única información adicional que necesitas (si recuerdas bien como lo has hecho usando el comando `docker container run`) es una **variable de entorno con la contraseña de root**.

Para añadir variables de entorno:
```yaml
services:
  mi-php:
    image: php:8.4-apache
    ports:
      - "8080:80"
    volumes:
      - ./:/var/www/html    # En este caso vamos a poner la ruta relativa (./ es el directorio actual)

  mi-bd:
    ...
    environment:
      - VARIABLE_DE_ENTORNO=VALOR1
      - VARIABLE_DE_ENTORNO2=VALOR2
      - VARIABLE_DE_ENTORNO3=VALOR3
      # ...
```

!!! Note "Ejercicio"
    1. Añade al compose.yml lo necesario para que arranque también una base de datos de MariaDB. Recuerda que tendrás que destruir los contenedores y volver a crearlos con comandos como: `docker compose up -d` y `docker compose down` (asegúrate de que se mantiene en ejecución después de arrancarla).


El contenedor de base de datos no ejecuta ningún script de creación de base de datos. Según la **documentación de la imagen de MariaDB en Dockerhub**, si copiamos cualquier script .sql en la carpeta `/docker-entrypoint-initdb.d/` este se ejecutará automáticamente la primera vez que creemos el contenedor.

!!! Note "Ejercicio"
    1. Crea un script básico que cree una base de datos cualquiera con una tabla y una fila en la tabla.
    2. Haz que esa base de datos se cree al crear el contenedor (tendrás que borrarlo con `docker compose down` y luego crearlo de nuevo con up).
    3. Conéctate a la base de datos para verificar que se ha creado correctamente.

## Añadiendo volúmenes
Hasta ahora hemos usado un **bind mount** para compartir nuestro código fuente con el contenedor:

```yml
- ./src:/var/www/html
```

Eso está muy bien para el código, porque queremos editar los ficheros desde nuestro equipo y ver los cambios al instante. Sin embargo, para una base de datos normalmente no nos interesa montar una carpeta cualquiera del proyecto, sino **guardar los datos de forma persistente en un volumen de Docker**.

La idea importante es esta:

- Un **bind mount** suele usarse cuando queremos compartir una carpeta concreta de nuestro equipo.
- Un **volumen** suele usarse cuando queremos que Docker gestione los datos de forma persistente.

En una base de datos esto es especialmente útil, porque si eliminas el contenedor pero conservas el volumen, **los datos siguen existiendo**.

Por ejemplo, un servicio MariaDB podría quedar así:

```yml
services:
  mi-bd:
    image: mariadb:latest
    environment:
      - MARIADB_ROOT_PASSWORD=abc123
    volumes:
      - ./sql:/docker-entrypoint-initdb.d  # Ponemos los scripts de inicializacion en una carpeta "sql".
      - datos-mariadb:/var/lib/mysql       # NUEVO VOLUMEN: datos persistentes de MariaDB

volumes:                                   # Añadimos esto al final para declarar el volumen
  datos-mariadb:
```

Fíjate en dos cosas:

1. Dentro del servicio `mi-bd`, en la sección `volumes`, aparece la línea `datos-mariadb:/var/lib/mysql`.
2. Al final del fichero aparece otra sección de nivel superior llamada `volumes`, donde declaramos el volumen `datos-mariadb`.

La carpeta `/var/lib/mysql` es importante porque ahí es donde MariaDB guarda internamente sus datos. Por tanto, al asociar esa ruta a un volumen, conseguimos que la información de la base de datos no desaparezca aunque el contenedor sea destruido.

Esto cambia bastante el comportamiento respecto a antes:

- Si haces `docker compose down`, el contenedor se elimina.
- Pero el volumen normalmente **no se borra**, así que los datos permanecen.
- Si haces después `docker compose up -d`, la base de datos volverá a aparecer con su información anterior.

Solo desaparecerá si eliminas también los volúmenes, por ejemplo con:

```bash
docker compose down -v
```

Ese `-v` aquí sí es importante, porque le estás diciendo a Docker que además de destruir los contenedores elimine también los volúmenes asociados.

!!! Note "Ejercicio"
    1. Basándote en el código dado por aquí, crea tu `compose.yml` de manera que levante 2 contenedores (el "mi-php" y el "mi-db"). El contenedor de MariaDB debe usar un volumen llamado `datos-mariadb`.
    2. Crea un pequeño script que cree una tabla de base de datos sencilla e inserte una fila en ella. Debe ejecutarse solo al arrancar el contenedor.
    3. Levanta los contenedores y asegúrate de que la base de datos funciona correctamente.
    4. Ejecuta `docker compose down` y después `docker compose up -d`.
    5. Comprueba si los datos siguen ahí. Si siguen existiendo, intenta explicar con tus palabras por qué ha ocurrido.
    6. Finalmente, ejecuta `docker compose down -v`, vuelve a levantar el entorno y comprueba qué ha pasado ahora con los datos.

## Lista de comandos de docker
```bash
# Validar sintaxis de tu compose.yml y ver el resultado final tal como lo interpreta docker
docker compose config

# Recrea de nuevo los contenedores en caso de que la imagen cambiase (actualiza la imagen y levanta el contenedor de nuevo si la imagen cambió)
docker compose up --build

# Recrea los contenedores
docker compose up --force-recreate

# Elimina los contenedores y las redes y volúmenes anónimas creadas con estos
docker compose down

# Elimina los contenedores y todos sus volúmenes asociados
docker compose down -v

# Ver la información de todos los servicios que hemos definido en el compose.yml
docker compose logs
```

## Ejercicios
### Añadido de PHPMyAdmin y volúmenes
Este ejercicio consistirá en modificar lo que acabamos de hacer para que se conecte a una base de datos MariaDB. Si eliminas el contenedor la base de datos debe mantenerse intacta. A continuación se dan algunas indicaciones de cómo hacerlo:

1. Pídele a una IA de tu elección que te de un script de base de datos con una tabla y un index.php asociado. Añádelo al index y trata de conectarte a base de datos.
2. Asegúrate de que al levantar el contenedor se crea la base de datos automáticamente. Esto lo puedes hacer tal como se indica en estos apuntes de teoría, copiando el fichero .sql en `/docker-entrypoint-initdb.d/`. Para realizar esta copia puedes crear **otro volumen que comparta esa carpeta con una carpeta tuya donde tengas el script de base de datos**.
3. Añade otro contenedor de nombre mi-phpmyadmin que cree un contenedor con PHPMyAdmin y te permita gestionar la base de datos. Tienes una imagen de PHPMyAdmin con toda su documentación en [este enlace](https://hub.docker.com/_/phpmyadmin).

### Monta un CMS con compose
En los ejercicios anteriores has montado un Wordpress con docker. Ahora vamos a simplificarlo usando compose.

Busca en Dockerhub una imagen de Wordpress y crea un compose.yml que monte un Wordpress completo.

### Monta un Nextcloud
Usa Docker para crear un entorno Nextcloud. Una vez montado el entorno:

- Configura el perfil de administrador.
- Crea cuatro usuarios y dos grupos. Haz que cada grupo tenga dos usuarios.
- Cambia el tema por defecto.
- Instala un cliente de escritorio para Nextcloud y conéctate al sevidor desde él.

Configura los volúmenes que consideres necesarios en el compose.yml (debe haber alguno al menos que consideres útil).
