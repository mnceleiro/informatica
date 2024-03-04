## Ejercicios generales
1. Crea una carpeta scripts en /usr/local/sbin/.
2. Haz un script que cree usuarios nuevos (los cuáles se pasan como parámetro) y debe crearse con shell /bin/bash y un home con el mismo nombre que el del usuario.
3. Prueba el script anterior con varios usuarios (tres de ellos que sean "test1", "test2" y "test3", ya que los aprovecharemos en siguientes ejercicios).
4. Crea un script que cree una copia de seguridad de los homes de los usuarios en /opt/backups con formato anho-mes-dia-home-<nombre-usuario>.tar.gz
5. El ejercicio anterior está bien, pero si el disco se estropea perdemos tanto los homes como las copias de seguridad. Modifica el script anterior para que en lugar de copiarse en tu ordenador se copie en otra máquina virtual mediante el comando scp (secure copy).
6. Crea un cronjob para el script anterior (desde el usuario root) de manera que la copia de seguridad de los homes se realice todos los días a una hora y minuto concreto (el que quieras).
7. Ya disponemos de copias de seguridad automatizadas que se pasan de un servidor a otro, el problema es que no tenemos logs de lo que ocurre. Crea una carpeta backup-log en el directorio de logs de tu distribución GNU/Linux. Modifica el script de backups para que escriba una línea en el fichero de log indicando el día y hora exacta y si la copia ha dado "error" o "success".
8. Opcional: configura el logrotate para que se borre la información de ese fichero de logs cada semana o cada vez que supere los 50MB.
9. Intenta ejecutar un comando con "sudo" con el usuario test1. ¿Es posible? ¿por qué?
10. Revisa el fichero de grupos de Linux y mira si hay algún usuario sudo. Añade el usuario "test1" al grupo "sudo" (busca en internet el comando usermod). Comprueba de nuevo si puedes ejecutar comandos como sudo con test1.
11. Crea un nuevo usuario benito (con useradd) y añádelo al grupo sudo en el mismo comando.
12. Cambia la contraseña del usuario y logeate (prueba si ejecuta comandos como sudo).
13. Aunque añadir un usuario al grupo de sudo es una solución, existe un fichero (/etc/sudoers) que nos da mucha más potencia, permitiéndonos ejecutar solo ciertos comandos según usuarios o grupos. Consulta esta URL (aunque no haremos nada con esto de momento).
14. Una vez leído el artículo, elimina a test1 del grupo "sudo".
15. Crea tres grupos nuevos: un grupo de nombre alumnado, otro profesorado y otro ies.
16. Añade al usuario test1 a profesorado y a test2 y test3 a alumnado (puedes probarlo ahora con groupadd). Añade los tres usuarios de test al grupo ies. Usa cat y grep para filtrar estos usuarios y grupos en los ficheros del sistema donde se almacena esta información (observa los cambios).
17. Cambia el nombre del grupo ies a pinguela (puedes usar groupmod, revisa el manual, u otro comando que encuentres). Filtra ahora el fichero de grupos por ies (no debería salir nada) y por pinguela (que es el nuevo nombre) y observa como cambió.
18. Añade a tu usuario principal al grupo pinguela (como grupo secundario, ya que el grupo principal tendrá el mismo nombre que tu usuario).
