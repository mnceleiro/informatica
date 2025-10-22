## Wordpress
Debes hacer todo, pero solo tendrás que documentar los que ponen "Ejercicio" (las instalaciones de CMS).

## Descarga de Wordpress y copia de los ficheros en el directorio de Apache

Entra a [https://wordpress.org](https://wordpress.org) y descarga la última versión de Wordpress. Puedes copiarlo de varias maneras, pero en este caso vamos a utilizar una herramienta de terminal (puedes usar `wget` o `curl`) para descargarlo. WGET y CURL son herramientas para descargar ficheros online pasando como parámetro la URL de descarga:

Ejecuta lo siguientes desde tu máquina en AWS:

```bash
wget <url_del_fichero_a_descargar>
```

Ahora descomprímelo y copia el contenido a la carpeta /var/www/html.

## Configuración de la base de datos
Vamos a crear una base de datos para Wordpress. Conéctate a MariaDB y ejecuta lo siguiente:
```sql
CREATE DATABASE if not exists wordpress;
CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'wp_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost';
FLUSH PRIVILEGES;
```

Una vez hecho esto, debería funcionarte Wordpress al entrar en la URL de tu Apache. En caso de que falle, es posible que no tengas PHP, el soporte de PHP para Apache o el soporte de PHP con MySQL instalado:

```bash
sudo apt install php libapache2-mod-php php-mysql
```

Ahora, deberías ser capaz de entrar en tu Wordpress mediante la URL de tu servidor. Pruébalo y crea tu primer post en el blog!

### Ejercicio: instala WordPress
Volvemos con Vagrant.

Ahora ya sabes todo lo necesario para instalar sistemas web en tu servidor GNU/Linux. Has redireccionado puertos, instalado sistemas gestores de bases de datos (MySQL/MariaDB), creado usuarios y bases de datos en ellas y descargado y configurado un CMS (Wordpress).

Tu meta ahora es hacerlo tú solo (sin guía).

**Crea una máquina nueva en Vagrant y Ubuntu 24.04 e instala Wordpress en ella (puedes usar la box mnceleiro/ubuntu24 u otra de tu elección). No hay instrucciones y este trabajo deberás hacerlo por tu cuenta.**

Se recomienda que **anotes todo lo que hagas** para tener claro los cambios que realizaste en la máquina si surgen problemas. Utiliza **todo lo aprendido hasta ahora** para montar un **WordPress** en tu máquina con Vagrant y Virtualbox.

!!! Nota
    Recuerda que ya has instalado Wordpress si has seguido todos los ejercicios, pero no olvides que ha sido muy guiado. Esto es, hemos ido gradualmente instalando Apache en Virtualbox y AWS, configurado permisos, creado la base de datos y el usuario para conectarnos, descargado Wordpress, copiado los ficheros a /var/www/html, etc.

    Hay muchos pasos a seguir, intenta razonarlos y seguirlos para conseguir montar este CMS en tu sistema!

### Ejercicio: instala Moodle
En una máquina como la anterior, instala un Moodle y crea un curso.

### Ejercicio: instala Drupal
En una máquina como la anterior, instala Drupal y crea un post. Intenta lograr que la conexión al Moodle sea en el puerto 8080 (en lugar de en el 80).

### Ejercicio: instala Prestashop
Como ejercicio opcional, intenta instalar Prestashop.