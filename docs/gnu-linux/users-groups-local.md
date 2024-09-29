# Gestión de usuarios y grupos
A continuación se muestra en un tutorial en vídeo como gestionar usuarios y grupos locales en Debian y derivados:
![type:video](https://www.youtube.com/embed/ApjqEymyTRE)

Además, a continuación tienes una chuleta de varios de los ficheros y comandos utilizados.

## Información sobre usuarios y grupos
La información de los usuarios y grupos locales que hay en el sistema, en GNU/Linux, **la información sobre gestión de usuarios y grupos se almacena en los siguientes ficheros**:

| Fichero | Descripción |
| ------- | ----------- |
| /etc/passwd | Fichero de usuarios. |
| /etc/group | Fichero con los grupos |
| /etc/shadow | Fichero con las contraseñas (encriptadas) |
| /etc/skel | Es el esqueleto de creación de un nuevo usuario. Esto es, cuando se crea un nuevo usuario mediante el comando **useradd**, los ficheros que haya en /etc/skel se copiarán en su home. |
| /etc/default/useradd | Aquí se define donde está el esqueleto (/etc/skel por defecto) para crear nuevos usuarios y el SHELL que se usará por ellos. | 

## Comandos de gestión de usuarios

| Comando | Descripción |
| - | - |
| id<br/>id [-un] | Muestra el id y nombre del usuario actual y todos los grupos en los que está (tanto el principal como lo secundarios). Se podría obtener la misma información con un: **cat /etc/group \| grep "usuario"** |
| whoami | Muestra solamente el usuario actual que está ejecutando el comando. Es equivalente a hacer un **id -un**. |
| adduser | Crea un usuario de forma interactiva (este no nos es útil para automatizar tareas mediante scripts). |
useradd | Crea un usuario. La sintaxis es la siguiente:<br /><br />useradd -m [-d ruta_carpeta_home] [-s shell_a_utilizar] <nombre_usuario>. <br/><br/>Un ejemplo real, para el usuario "marcos", podría ser el siguiente:<br />**useradd** **-m** **-d** /home/marcos **-s** /bin/bash **marcos**. |
| chmod | chmod u+r \<fichero> → Añade permisos de lectura (**R**ead) al usuario.<br/>chmod u+w \<fichero> → Añade permisos de escritura (**W**rite) al usuario.<br />chmod u+x \<fichero> → Añade permisos de ejecución (e**X**ecution) al usuario.<br/><br/>Además, si en lugar de la **u (usuario, user)** usamos la **g (grupo, group**) o la **o (otros, others)** podemos dar permisos a los usuarios pertenecientes al mismo grupo u a otros. La letra **a (todos, all)** sería para dar permiso a todos los usuarios (p. ej: permiso de ejecución a usuario, grupo y otros: a+x).<br/><br/>Si en lugar de dar un permiso queremos quitarlo, solo tenemos que cambiar el + por un -.<br/><br/>Puedes consultar [más información sobre permisos en este artículo](https://phoenixnap.com/kb/linux-file-permissions). |
| chown | chown <usuario> <fichero><br/>chown 