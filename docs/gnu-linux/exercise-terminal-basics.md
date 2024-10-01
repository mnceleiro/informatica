# Actividad I: manejo de terminal
Crea una máquina con Virtualbox o Vagrant y Ubuntu 22.04 o superior donde el nombre de tu máquina sea tu nombre y la primera letra de tu primer y segundo apellido. Por ejemplo, para mi sería: marcosnc.

Crea un documento con capturas de cada paso de los ejercicios siguientes. El documento debe tener:

- Portada con el nombre de la actividad y tu nombre y apellidos.
- Los enunciados copiados (y debajo las capturas). Puedes hacer una captura única para varios puntos (por ejemplo, puedes cubrir el 4, 5 y 6 con una sola captura si la has hecho bien).
- Las páginas deben estar numeradas.

A continuación van los ejercicios. No hagas nada con el usuario "root". En algunas tareas necesitarás sudo (úsalo solo si se indica o si lo necesitas).

## Tareas sobre ficheros y carpetas
Comenzamos con la actividad. **No te muevas con cd a ninguna carpeta a no ser que se te indique.**

1. Sitúate en tu home (/home/<tu_usuario\>).
2. Crea una carpeta "Actividad_1" en tu home (hay un espacio en el nombre de la carpeta, tienes que ponerlo). Mira de estar seguro cuál es "tu home", tu home es tu carpeta personal (no la carpeta /home, sino /home/<tu_usuario\>).
3. Sin moverte de tu home, **crea una carpeta <nombre_apellido1\> dentro de "Actividad_1" usando una ruta absoluta** (donde <nombre_apellido1\> es tu nombre y apellido). Dentro de esta carpeta, crea las siguientes carpetas **con un solo comando** y también ruta absoluta:

    - Una carpeta llamada "datos".
    - Otra carpeta llamada "copias_seguridad".
    - Otra carpeta "expedientes antiguos" (con el espacio).
    - Otra carpeta "informacion obsoleta" (con el espacio).

    !!! Note "Nota"
        Los textos entre "<>" significan que el campo es obligatorio. Por ejemplo: <nombre_apellido1\> indica que tienes que poner obligatoriamente tu nombre y apellido pero sin los símbolos "<>". Por ejemplo, en mi caso tendría esta ruta: /home/marcos/Actividad_1/marcos_nunez (fíjate que no pongo los "<>").

        Por otro lado, si el texto se pone entre corchetes "[]" indica campo opcional (podría ponerse o no).

4. Crea un fichero de nombre "prueba" en la carpeta "informacion obsoleta" usando ruta absoluta o relativa (la que prefieras).
5. Sigues en tu home (no te muevas). Ahora, crea una **carpeta nueva llamada "expedientes_empleados" dentro de "datos"** usando una **ruta relativa**.
6. Vamos a cambiarnos de carpeta. Accede con cd a la carpeta "expedientes_empleados" **con un solo comando y rutas relativa**.
7. Ve a ChatGPT u otra herramienta de IA y dile que te genere 20 DNIs inventados y que los ponga en la misma línea, separados por espacios.
8. Copia esos dnis y úsalos para crear, desde donde estás, 20 ficheros (uno por dni). Solo tienes que escribir el comando y copiar y pegar esos dnis y te creará las carpetas.
9. Ahora vamos a practicar el renombrado (comando mv). Renombra dos de los ficheros que has creado a otro dni inventado por ti.
10. Ahora, en la misma carpeta en la que estás (donde tienes todos esos ficheros) **crea un fichero "informacion_general.txt" con una línea que ponga "Aquí están todos los expedientes de los empleados."**. **Tienes que hacer esto con un solo comando** (puedes usar echo y la redirección ">").
11. Sitúate en tu home (/home/<tu_usuario\>).
12. Estás en tu home. Al principio de la práctica has creado una carpeta llamada "copias_seguridad". Copia la carpeta "expedientes_empleados" en la carpeta "copias_seguridad".
13. Esta última tendrás que buscarla en internet. Desde donde estás, empaqueta y comprime la carpeta ~/<nombre_apellido1\>/copias_seguridad/expedientes_empleados (tar.gz). Te dejo un [buen tutorial de como usar el comando tar](https://www.howtogeek.com/248780/how-to-compress-and-extract-files-using-the-tar-command-on-linux/).

### Tareas LPIC
LPIC significa Linux Professional Institute. Este instituto tiene varios certificados oficiales (hay que realizar un examen y hay varios niveles) y recursos a estudiar.

Lee el tutorial y realiza todos los ejercicios disponibles en los enlaces siguientes (los ejercicios están abajo de todo en la web, hacedlos todos):

- Tarea 1: [Usando la línea de comandos para obtener ayuda](https://learning.lpi.org/es/learning-materials/010-160/2/2.2/2.2_01/){:target="_blank"}.
- Tarea 2: [Usando directorios y listando archivos](https://learning.lpi.org/es/learning-materials/010-160/2/2.3/2.3_01/){:target="_blank"}.
- Tarea 3: [Creando, moviendo y borrando archivos](https://learning.lpi.org/es/learning-materials/010-160/2/2.4/2.4_01/){:target="_blank"}.

**Las tareas vienen con solución, pero quiero capturas de la ejecución de los comandos de las tareas, es decir, quiero ver que los probais**.

## Instalación de paquetes y otros comandos
1. Actualiza el sistema (update y upgrade).
2. Prueba el comando sl (si no lo tienes instalado debería darte un error).
3. Instala el paquete sl (usando la herramienta apt). Recuerda que para instalar necesitas ejecutar el comando como sudo.
4. Prueba de nuevo el comando sl.
5. Instala el paquete tree 
6. Prueba la herramienta tree: `tree Actividad_1`. Esto te dará una visión global de las carpetas y ficheros que has creado.

## Contenido de ficheros
1. Mira solo las últimas líneas del [fichero donde se guardan todos los usuarios en Linux](../users-groups-local/). Si no recuerdas el comando está en estos mismos apuntes (o puedes buscarlo en internet y lo encontrarás rápido!).
2. Mira las primeras 14 líneas del fichero de contraseñas (/etc/shadow). Necesitarás permisos de administrador.
3. En el fichero de grupos, muestra las 11 primeras líneas.
4. Escribe un comando que cuente las líneas del fichero de usuarios.

## Usuarios, grupos y permisos
La teoría de esta parte está en el apartado de [gestión de usuarios y grupos](../users-groups-local/#comandos-de-gestion-de-usuarios){:target="_blank"}. Para esta parte necesitarás sudar bastante (comando sudo).

1. Dale permisos de forma recursiva a la carpeta de expedientes de la siguiente manera:
       - El propietario tendrá permiso de lectura, escritura y ejecución.
       - El grupo tendrá solo permiso de lectura y ejecución, pero no escritura.
       - Otros no tendrán permisos de ningún tipo.
2. Crea un fichero con tu nombre en tu home y dale permisos de lectura y escritura y ejecución para el usuario; lectura, escritura y ejecución para el grupo; lectura y ejecución para "otros".
3. Crea un usuario con las siguientes características (usando el comando useradd obligatoriamente).
      - Nombre de usuario: mostovoi.
      - Carpeta personal: /home/mostovoi.
      - Shell: /bin/bash.
4. Cambia la contraseña de ese usuario (comando: `passwd <usuario\>`).
5. Identifícate con ese usuario (comando `su - usuario`).
6. Verifica que estás /home/mostovoi.
7. Verifica que eres el usuario mostovoi (comando `whoami`).
8. Cierra la sesión con mostovoi (es decir, vuelve a la sesión anterior). Es el comando `exit`.
9. Crea ahora un usuario nuevo con tu nombre:
       - Nombre de usuario: tu nombre.
       - Carpeta personal: /home/emp_<tunombre\>. En mi caso sería: emp_marcos.
       - Shell: /bin/bash.
10. Haz un ls -l de /home para comprobar que se ha creado la carpeta correctamente.
11. Crea un grupo de nombre empleados.
12. Añade los dos usuarios al grupo "empleados".
13. Asígnale a la carpeta "copias_seguridad": lectura, escritura y ejecución para el usuario, lectura y ejecución para el grupo y solo ejecución para otros.
14. Convierte al usuario mostovoi en propietario de la carpeta "copias_seguridad" (comando chown). Verifica que ha funcionando viendo los permisos con el comando: `ls -l`.
15. Elimina los dos usuarios y el grupo empleados.

## Redireccion de entrada/salida estándar "<", ">", ">>"
Una de las cosas más importantes a aprender en GNU/Linux es como redireccionar a ficheros. Para ello se usan los caracteres ">", "<" y ">>". La otra son las tuberías (caracter "|"), que nos permiten mandar la salida de un comando como entrada de otro.

1. Ejecuta el comando: `echo "Mi nombre es <tunombre_tuapellido1/>.`"
2. Ejecuta el comando `echo "Mi nombre es <tunombre_tuapellido1/>. > ~/misdatos.txt`
3. Mira el contenido del fichero con el comando cat.
4. Ejecuta otras dos veces el comando del punto 2 y vuelve a revisar el fichero, ¿ha cambiado algo? ¿crees que debería?
5. Ahora vamos a modificar un poco el comando: `echo "Mi nombre es <tunombre_tuapellido1/>. >> ~/misdatos.txt` (ahora lleva dos símbolos ">>"). **Ejecuta el comando 3 veces.**
6. Revisa de nuevo con cat el contenido del ficher, ¿qué ha cambiado? ¿por qué? Explica la diferencia entre usar > y >>
7. Ahora haz lo mismo con ls -la. Haz un `ls -la` de tu home adáptalo para que el resultado no salga por pantalla, sino que la salida del comando se redirija al fichero "resultado_ls.txt" (pista, es como antes: usando el ">").
8. Ahora modifica el comando para que se añadan nuevas líneas al fichero cada vez que ejecutas el comando.

## Conectividad básica
1. Ejecuta el comando en Linux para mirar cuál es tu IP (`ip address`). Indica:
       - ¿Cuál es tu ip privada?
       - ¿Cuál es tu ip de loopback?
       - ¿Qué es la ip de loopback?
2. Ejecuta otro comando de linux para ver tu ip: `ifconfig`. Si te da un error haz lo que sea para arreglarlo y que el comando funcione.
3. Comprueba la conectividad con google.com.
4. Comprueba cuál la dirección de tu servidor DNS (busca en internet el comando y pruébalo).
5. Mira la IP privada de tu ordenador principal (probablemente tengas Windows, tendrás que buscar el comando). ¿Cuál es la puerta de enlace? ¿Qué dispositivo de tu casa es el que tiene asignada esa puerta de enlace?