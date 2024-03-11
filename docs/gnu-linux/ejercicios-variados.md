
## Lista de ejercicios simples
1. Crea una carpeta scripts en /usr/local/sbin/ y otra en /usr/local/bin.
2. Haz que cada usuario nuevo que se cree tenga en su home una carpeta "normativa-empresa" con un txt "normas.txt" dentro.
3. Crea un script en la carpeta de scripts de sbin que cree usuarios nuevos (los cuáles se pasan como parámetro) y debe crearse con shell /bin/bash y un home con el mismo nombre que el del usuario. [Utiliza alguna función en el script](https://ioflood.com/blog/bash-function/). A partir de ahora practica los scripts usando funciones.
4. Prueba el script anterior con varios usuarios (tres de ellos que sean "test1", "test2" y "test3", ya que los aprovecharemos en siguientes ejercicios). Mira si aparece la carpeta "normativa-empresa" en el home de os usuarios.
5. Crea un script que cree una copia de seguridad de los homes de los usuarios en /var/backups/homes con formato anho-mes-dia-<nombre-usuario>.tar.gz
6. (Opcional) El ejercicio anterior está bien, pero si el disco se estropea perdemos tanto los homes como las copias de seguridad. Modifica el script anterior para que en lugar de copiarse en tu ordenador se copie en otra máquina virtual mediante el comando scp (secure copy), quizá tengas que instalarlo.
7. El crontab permite ejecutar comandos en un instante de tiempo que se le indique (p. ej: todos los lunes a las 7 de la mañana, todos los días a las 12:00 y a las 14:00, etc.).
   1. Haz un cat del fichero /etc/crontab y leelo.
   2. Busca en internet sobre el crontab.
   3. Prueba los comandos crontab -l (lista las tareas configuradas) y crontab -e (comando recomendado para editar el fichero crontab).
8. Vamos a testear un cronjob. Crea (usando crontab -e desde tu usuario) un cronjob que añada a un fichero de nombre test-cronjob.txt en tu home una línea con el resultado del comando "date" de linux.
9. Crea un cronjob (crontab -e) desde el usuario root para el script anterior (de backups de los homes) de manera que la copia de seguridad de los homes se realice todos los días a una hora y minuto concreto (el que quieras).
10. Revisa los logs de /var/log/syslog filtrando por "cron". Ahí podrás ver información sobre la ejecución de las tareas definidas en el crontab.
11. Una vez verifiques que funciona, elimina la línea del cron (ya podemos generar problemas de espacio en la vm).
12. Ya disponemos de copias de seguridad automatizadas que se pasan de un servidor a otro, el problema es que no tenemos logs de lo que ocurre. Crea una carpeta backup-log en el directorio de logs de tu distribución GNU/Linux. Modifica el script de backups para que escriba una línea en el fichero de log indicando el día y hora exacta y si la copia ha dado "error" o "success".
13. Opcional: configura el logrotate para que se borre la información de ese fichero de logs cada semana o cada vez que supere los 50MB.
14. Intenta ejecutar un comando con "sudo" con el usuario test1. ¿Es posible? ¿por qué?
15. Revisa el fichero de grupos de Linux y mira si hay algún usuario sudo. Añade el usuario "test1" al grupo "sudo" (busca en internet el comando usermod). Comprueba de nuevo si puedes ejecutar comandos como sudo con test1.
16. Crea un nuevo usuario benito (con useradd) y añádelo al grupo sudo en el mismo comando.
17. Cambia la contraseña del usuario y logeate (prueba si ejecuta comandos como sudo).
18. Aunque añadir un usuario al grupo de sudo es una solución, existe un fichero (/etc/sudoers) que nos da mucha más potencia, permitiéndonos ejecutar solo ciertos comandos según usuarios o grupos. Consulta esta URL (aunque no haremos nada con esto de momento).
19. Una vez leído el artículo, elimina a test1 del grupo "sudo".
20. Crea tres grupos nuevos: un grupo de nombre alumnado, otro profesorado y otro ies.
21. Añade al usuario test1 a profesorado y a test2 y test3 a alumnado (puedes probarlo ahora con groupadd). Añade los tres usuarios de test al grupo ies. Usa cat y grep para filtrar estos usuarios y grupos en los ficheros del sistema donde se almacena esta información (observa los cambios).
22. Cambia el nombre del grupo ies a pinguela (puedes usar groupmod, revisa el manual, u otro comando que encuentres). Filtra ahora el fichero de grupos por ies (no debería salir nada) y por pinguela (que es el nuevo nombre) y observa como cambió.
23. Añade a tu usuario principal al grupo pinguela (como grupo secundario, ya que el grupo principal tendrá el mismo nombre que tu usuario).

## Ejercicio de documentación de scripts
Crea una carpeta bin en tu home y crea un fichero de nombre nuevo-script que pida los siguientes datos y, si se pulsa enter sin introducir nada use lo que hay entre corchetes.

- Nombre del script (obligatorio):
- Intérprete de comandos [/bin/bash]:
- Autor [el nombre y apellidos de tu usuario]:
- Fecha [fecha-de-hoy]:
- Descripción (opcional):

Los datos introducidos deberán concatenarse en un comentario al inicio del fichero de la siguiente manera:

```bash
#!/bin/bash
# Author: Nombre y apellidos
# Date: 27/02/2024
# Description: este script comprueba.... lo que sea
# Modificado: 27/02/2024
salto de línea

```

Una vez creado el fichero y concatenadas las líneas, el fichero debe abrirse automáticamente con el comando vim: vim <nombre-fichero>.

### Añadiendo mejoras
- Añade la carpeta bin de tu home al PATH de forma permanente, de manera que puedas ejecutar el script solo usando el comando "nuevo-script".
- Cambia el script a algo con menos texto (p. ej: en lugar de "nuevo-script" usar "nscr") y prueba si sigue funcionando (quizá tengas que cerrar sesión y abrir o recargar el .bashrc).
- Modifica el script para que solo pida el script de forma interactiva si no se pasan parámetros. En caso de pasar un parámetro este será ya el nombre del script y no se preguntará. Además, si se pasa más de un parámetro se mostrará un mensaje de error y se devolverá un código 22.
