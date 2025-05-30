# Docker Compose

## ¿Qué es y para qué sirve?
Docker compose es una herramienta para definir y ejecutar [aplicaciones multi-contenedor](https://docs.docker.com/compose/) en docker. En él, con un solo fichero **compose.yml** podemos levantar múltiples contenedores de forma centralizada y sencilla (con un solo comando, mucho más fácil que como hemos hecho hasta ahora).

## Creando contenedores con docker compose
Para crear contenedores con docker compose el fichero debe llamarse de una de las siguientes maneras:

- compose.yaml
- compose.yml
- docker-compose.yaml
- docker-compose.yml

Al ejecutar el comando `docker compose up` automáticamente el demonio de docker buscará siempre uno de esos ficheros en el directorio actual. Si no lo hay, no funcionará.

Veamos un ejemplo básico de un index.php sencillo:
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

Tenemos ese fichero que muestra un "Hello world" usando un `echo` de PHP. Vamos a ver como, sin necesidad de instalar PHP en nuestro sistema, podemos dockerizar esta aplicación.

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

Bien, vamos a ver como levantar el contenedor. **Si NO USAMOS docker compose podríamos hacer lo siguiente**:
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

**Esto ya lo habíamos visto antes**. En este caso, **NO SE ESTÁ USANDO PARA NADA EL FICHERO compose.yml**. Vamos a ver **como hacer lo mismo con docker compose:**

```bash
# Levantar TODOS los contenedores declarados en el compose.yml
docker compose up

# Levantar TODOS los contenedores en modo dettached (-d)
docker compose up -d

# Parar TODOS los contenedores que haya declarados en el compose.yml
docker compose stop

# Eliminar todos los contenedores
docker compose down

# Eliminar todos los contenedores (y sus volúmenes si están declarados)
docker compose down -v
```

Es **mucho más simple**. Esto es, solo con hacer `docker compose up -d` podemos levantar uno (o muchos) contenedores y con `docker compose down` eliminarlos todos de un plumazo.

!!! Note "Ejercicio"

    1. Crea el fichero .php anterior y el compose.yml (ve escribiéndolo tu línea a línea para interiorizar el conocimiento, no hagas copy-paste).
    2. Una vez creado, intenta levantarlo con docker compose en modo **detached** (-d).
    3. Prueba si funciona la página web... ¿debería funcionar 🤔?.

    Probablemente no te funcione la página o te de un error *403 forbidden*. Ahora la pregunta es, ¿por qué? ¿Debería enseñarnos el index que creamos? ¿Si lo llegamos a usar con `docker container run` funcionaría o falta algo más?

    Finalmente, **apaga el contenedor** (no soluciones el problema de código aún, lo haremos en la siguiente sección).

## Añadiendo puntos de montaje
Ya sabemos cositas, pero aún no podemos subir nuestro código al contenedor!!! Vamos a ello, necesitamos un **punto de montaje**. 

Primero de todo, vamos a recordar como lo hacíamos sin compose:
```bash
# Sincronizamos la carpeta de mi proyecto, por ejemplo: /home/marcos/desarrollo/mi-php, con la /var/www/html del contenedor
docker container run --name mi-php -d -p 8080:80 -v /home/marcos/desarrollo/mi-php:/var/www/html:/var/www/html php:8.4-apache
```

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

Con esto todo lo que hay en mi directorio actual se copiará al contenedor a la carpeta `/var/www/html`.

!!! Note "Ejercicio"
    1. Añade el volumen al contenedor del compose.yml.
    2. Tenemos que destruir el contenedor y crearlo de nuevo para que todo funcione. Mira los contenedores en ejecución con `docker container ls -a` y con `docker compose ls -a`.
    3. Destruye los contenedores con `docker compose... y algo más!`.
    4. Crealos de nuevo y prueba a acceder otra vez desde el navegador web. Debería aparecer la página.

## Accediendo a los contenedores
Podemos acceder a los contenedores con el comando habitual (`docker container exec`).

!!! Note "Ejercicio"
    1. ¿Cómo se llama el contenedor que se ha creado? ¿Qué patrón sigue el nombre?
    2. Accede al contenedor usando su nombre y lista los ficheros que hay en /var/www/html. ¿Cuáles son?

Como habrás visto, el contenedor sigue el patrón <nombre_carpeta>-<nombre_en_el_yaml>-<numero>. Por ejemplo: proyecto-php-mi-php-1. Usar este nombre es un poco "complicado" o enredoso, pero **docker compose también nos ayuda con esto**.

Usando `docker compose --help` verás que también existe el parámetro **exec** (es decir, puedes hacer lo mismo don `docker compose exec` que has hecho con `docker container exec` pero ahora puedes usar el nombre `mi-php` que has definido en el yaml).

!!! Note "Ejercicio"
    1. Ejecuta `docker compose --help` y mira si hay la opción exec.
    2. Prueba de nuevo a abrir un terminal de bash en el contenedor pero ahora usando `docker compose exec`. Recuerda, con `docker compose exec` puedes usar directamente el nombre que has definido en el yaml.
    3. Lista de nuevo lo que hay en /var/www/html.
    4. Habrás visto que hay un fichero compose.yml en el directorio (lo cuál no está muy bien). **Modifica tu fichero compose.yml para que el código de tu aplicación esté en una carpeta "src"**. La jerarquía debería quedar tal que así: 
          - ./compose.yml
          - ./src/
          - ./src/index.php
    
    Una vez has terminado con esto, deberías poder modificar tu código desde Visual Studio Code y esos cambios se reflejarán inmediatamente en la página web. Confírmalo.

## Añadiendo un contenedor de base de datos
Para añadir un nuevo contenedor, simplemente tenemos que hacer lo siguiente:
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

Bien, dentro de bd, de nuevo puedes meter imagen, puertos, volúmenes, etc. Ya has hecho esto antes con docker, así que ahora lo haremos con docker compose. La única información adicional que necesitas (si recuerdas bien como lo has hecho usando el comando `docker container run`) es una **variable de entorno con la contraseña de root**.

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

## Añadiendo volúmenes
El contenedor de base de datos no ejecuta ningún script de creación de base de datos. Según la **documentación de la imagen de MariaDB en Dockerhub**, si copiamos cualquier script .sql en la carpeta `/docker-entrypoint-initdb.d/` este se ejecutará automáticamente la primera vez que creemos el contenedor.

Igual que hemos añadido un punto de montaje (bind mount) con la etiqueta "volume", se hace igual para volúmenes. Puedes crear un volumen para una base de datos de manera que al arrancar y eliminar el contenedor no se pierdan los datos de la base de datos.

## Ejercicios finales
### Completando nuestro entorno con PHPMyAdmin y volúmenes
Este ejercicio consistirá en modificar lo que ya tienes para que se conecte a una base de datos MariaDB. Si eliminas el contenedor la base de datos debe mantenerse intacta. A continuación se dan algunas indicaciones de cómo hacerlo:

1. Pídele a ChatGPT u otra IA que te de un script de base de datos con una tabla y un index.php asociado. Añádelo al index y trata de conectarte a base de datos.
2. Asegúrate de que al levantar el contenedor se crea la base de datos automáticamente. Esto lo puedes hacer tal como se indica en estos apuntes de teoría, copiando el fichero .sql en `/docker-entrypoint-initdb.d/`. Para realizar esta copia puedes crear **otro volumen que comparta esa carpeta con una carpeta tuya donde tengas el script de base de datos**.
3. Añade otro contenedor de nombre mi-phpmyadmin que cree un contenedor con PHPMyAdmin y te permita gestionar la base de datos. Tienes una imagen de PHPMyAdmin con toda su documentación en [este enlace](https://hub.docker.com/_/phpmyadmin).

### Creando un nuevo contorno
Crea una nueva carpeta y un compose.yml dentro para tu proyecto fin de ciclo (que tenga al menos dos contenedores, uno con tu aplicación y otro la base de datos). 

Si lo consigues y quieres ampliar más, puedes añadir otros contenedores adicionales como: PHPMyAdmin, separar frontend y backend, etc.