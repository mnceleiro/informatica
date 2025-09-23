# Actividad guiada: Instalación de servidores web en entornos Windows y GNU/Linux

## Requisitos
- Manejarse con Virtualbox y Vagrant (si no sabes Vagrant, puedes hacer todo con Virtualbox).
- Saber crear máquinas virtuales en AWS (si no tienes cuenta de AWS, puedes hacer todo en local con Virtualbox).

## Entrega
- La entrega se realizará obligatoriamente en **formato PDF** y debe tener:
  - Índice autogenerado.
  - Numeración de páginas.
  - Tu nombre y apellidos en la cabecera superior derecha de cada página.

## Creación del documento
1. Crea un documento de LibreOffice Writer o Microsoft Word (yo os daré soporte para hacer todo en LibreOffice) y una portada sencilla (basta que tenga el título de la tarea y tu nombre y apellidos). Luego puedes reutilizarla para otras prácticas del curso.
2. Genera un índice.
3. Pon tu nombre y apellido en la cabecera de todas las páginas.
4. Guarda el documento como: apellido1_apellido2_nombre_tarea_servidores_web.

A partir de ahora documenta todo el resto de la práctica en este documento. Añade los títulos correspondientes (usando títulos 1, 2, 3...) y copia los enunciados de cada parte (puedes hacer copy paste de los mismos).

### XAMPP en Windows

Existen tres paquetes en Windows y GNU/Linux que contienen una serie de tecnologías ya preparadas para trabajar con PHP, servidores web y servidores de base de datos. Estos son:

- WAMP: significa **W**indows, **A**pache, **M**ySQL (o **M**ariaDB) y **P**hpMyAdmin.
- LAMP: lo mismo pero la **L** es de **Linux** (en lugar de la **W** de **W**indows).
- XAMPP: como los anteriores pero se puede instalar el paquete en ambas plataformas, GNU/Linux y Windows (La **X** es de cross-platform).

Este tipo de aplicaciones son más populares en Windows que en GNU/Linux y son muy fáciles de instalar. Por esta razón, para esta práctica de servidores web vamos a empezar con este pequeño ejercicio de Windows.

Instala en una máquina virtual (o en tu propio pc) con Windows 10 o superior el paquete **XAMPP**.

*(Saca captura del XAMPP funcioanndo con tu nombre y apellidos de fondo en un bloc de notas)*

Muestra lo siguiente:
- El servidor web funcionando. Puedes hacerlo entrando a la web desde el navegador de la máquina virtual. Si la web funciona bien el navegador debería mostrate un fichero HTML, ¿puedes localizar la ruta en Windows donde se encuentra ese fichero?
- Crea una nueva web de manera que accedas desde *http://localhost/tunombre_tuapellido1* *(captura)*
- El servidor de base de datos MySQL/MariaDB desde el cliente (que ya viene instalado con XAMPP) PhpMyAdmin.
- Crea una tabla **Persona** con dni, nombre y apellidos (id autoincremental y clave primaria, nombre y apellidos). Insértate a ti mismo en la tabla. *(captura donde se vea la tabla y tu en ella)*

## Instalación y configuración básica de servidores web en GNU/Linux
Para desarrollar páginas o aplicaciones web a veces es común utilizar Windows y XAMPP o WAMP, pero en producción (aplicaciones reales) necesitamos tener un servidor dedicado con un servidor web instalado y configurado. En este ejercicio vamos a instalar Apache en GNU/Linux.

### Instalación de servidor web Apache en Debian
1. Crea una máquina virtual con Virtualbox y la última versión estable de Debian con entorno de escritorio.
2. Instala los *guest additions* y activa la compartición del portapapeles entre ambas máquinas.
3. Crea un usuario de nombre <tunombre_tuprimerapellido> con el comando *useradd*. Haz que este usuario tenga un home con el mismo nombre, como shell /bin/bash y que pertenezca al grupo *sudo* (de esta manera podrá ejecutar comandos como administrador).
4. Logueate en el terminal con ese usuario y haz el resto de la práctica con él (de esta manera se identificará que eres tu en el prompt). *(captura de ejecución del comando **groups** con ese usuario. Debería aparecer sudo en la lista de grupos.*
5. Mira si existe la carpeta /var/www en tu sistema, ¿existe?
6. Comprueba si puedes acceder desde la propia máquina a `localhost`, ¿puedes?
7. Instala apache (`apt install apache2`).
8. Comprueba ahora los 2 pasos anteriores de nuevo, explica por qué ahora funcionan ambos en 1 o 2 líneas.
9. Modifica el index.html para que solo aparezca una línea con tu nombre y apellidos en un <h1>. *(captura con el terminal y la página con tu nombre y apellidos)*.
10. ¿Puedes editar el index.html sin sudo? ¿Por qué (si o no) puedes? Explícalo teniendo en cuenta el usuario y grupo al que pertenece el fichero.
11. Mira la ip de tu máquna principal y tu ip de máquina virtual desde cada terminal. *(indica si están ambas máquinas en la misma red y captura de ambos terminales donde se vea la ip)*.
12. Intenta acceder al Apache de tu máquina virtual desde tu máquina host. Se hace igual que antes, poniendo la ip en el navegador (ahora en lugar de poner 127.0.0.1 o *localhost* pones la ip de la máquina virtua). Es probable que no te funcione y no se espera que lo haga (así que no te preocupes). ¿Por qué no funciona?
13. A no ser que hayas hecho algo antes, por defecto en Virtualbox las 2 máquinas no estarán en la misma red (ya que el adaptador de red está configurado como NAT) y por esto no podemos acceder a la máquina virtual desde la máquina host. Para ponerlo en la misma red que la máquina host, tenemos que ponerlo como adaptador puente o *bridge*. Apaga la máquina virtual y hazlo. Luego, arráncala de nuevo.
14. Entra desde el navegador de tu máquina host al servidor de tu máquina virtual. Ahora, al estar en adaptador puente, debería funcionar *(captura)*.