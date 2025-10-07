# Servidor web Apache
El propósito de un servidor web es "servir" páginas web. Escribimos una URL en un navegador y esa dirección nos devuelve los archivos de la página.

## Instalación y configuración de Apache
El nombre cambia según la distribución. En algunas distribuciones el paquetes es **httpd** y en otros **apache**.

En una máquina Debian/Ubuntu:
```
sudo apt update
sudo apt install -y apache
```

## Arrancar Apache
Para arrancar Apache hay que arrancar primero el servicio (si usas Ubuntu este se arranca automaticamente).

Vamos a mirar primero si el servicio está en ejecución:

=== "Debian/Ubuntu"
    ```
    systemctl status apache2
    ```

=== "Redhat"
    ```
    systemctl status httpd
    ```

Mira si aparece como habilitado (enabled) y en ejecución (active/running). En algunas distribuciones no está habilitado por defecto. Para habilitarlo y arrancarlo:

=== "Debian/Ubuntu"
    ```
    systemctl enable apache2
    systemctl start apache2
    ```

=== "Redhat"
    ```
    systemctl status httpd
    systemctl enable httpd
    systemctl start httpd
    ```

### Probando apache
Las páginas web están en: **/var/www/html/** (en Debian y derivados). Una vez instalado Apache, puedes probar que funciona entrando en tu ip local desde un navegador (escribe "localhost" en el navegador web de la máquina donde has instalado el paquete).

## Parar o reiniciar el servicio
Si en algún momento queremos parar el servicio (de aquí en adelante se usará solo Apache, si usas otra distribución será con httpd):

```bash
# Para el servicio
systemctl stop apache2

# Reinicia el servicio
systemctl restart apache2

# Habilitar/deshabilitar el servicio para que se ejecute al arrancar el sistema
systemctl enable apache2
systemctl disable apache2
```

=== "Ejercicio"

    !!! Note "Ejercicio: instalar y arrancar Apache en Debian"
        1. Instala Apache en la última versión de Debian (puedes usar Virtualbox o [Vagrant con este Vagrantfile](/ficheros/vagrant/vagrantfiles/bridge-debian)).
        2. Añade una interfaz (o cambia la que ya tienes) a adaptador puente, para que tu máquina y la virtual estén en la misma red (si has usado el script de Vagrant esto no hace falta, ya que ya viene definido en el Vagrantfile como *bridge*).
        3. Escribe `curl localhost` o `wget localhost` para ver si la página devuelve el HTML desde la misma máquina virtual.
        4. Finalmente, prueba desde tu equipo host a acceder a la ip de tu máquina virtual desde el navegador web para comprobar si entra correctamente a la página. Si tienes problemas consulta la pestaña de "Ayuda" de esta página.

=== "Ayuda"
    !!! Note "Ayuda"
        En caso de que hayas tenido problemas con el ejercicio para entrar desde tu máquina host a la máquina virtual comprueba lo siguiente:

        1. ¿Has comprobado con systemctl si Apache está arrancado? Compruébalo y si no lo está, arráncalo.
        2. Si quieres, por si reinicias la máquina, puedes hacer que Apache se arranque por defecto al iniciar la máquina con `systemctl enable`.
        3. Otro posible problema es el firewall. Por defecto, los sistemas basados en Debian traen el firewall `ufw` instalado y quizá también habilitado. Para este ejercicio puedes intentar deshabilitar el firewall (que quizá esté bloqueando el puerto 80) y probar de nuevo (busca en internet como deshabilitar ufw)

        No puedo abarcar todos los problemas posibles que puedan suceder pero... recuerda que tienes tanto Google como la IA para ayudarte ahora y que los vas a tener que usar tanto ahora como durante toda tu vida profesional. No tengas miedo a hacerlo de la forma correcta (para aprender). También, si estás viendo esto desde mis clases, consúltame sin ningún problema y te ayudaré!

## Carpeta de Apache (document root)
En Apache, la carpeta donde están almacenados los ficheros que sirve como web se llama el `document root`. El *document root* por defecto de Apache es `/var/www/html` (en Debian y derivados).

El *document root* por defecto de Apache se puede cambiar modificando su fichero de configuración. En Ubuntu este fichero está situado en: `/etc/apache2/sites-available/000-default.conf`. Podemos verlo consultando las primeras líneas del mismo con:
=== "Consulta del ficher 000-default.conf"

    ```
    head -n 15 /etc/apache2/sites-available/000-default.conf
    ```

=== "Resultado de ejecución del comando"

    ```
    <VirtualHost *:80>
            # Comentarios...

            ServerAdmin webmaster@localhost
            DocumentRoot /var/www/html

            # Comentarios...
    ```

La línea `DocumentRoot /var/www/html` define donde están los ficheros a servir por Apache. Si cambiamos esa línea podemos poner que el documento root esté en otro sitio de nuestra elección, por ejemplo en: /home/marcos/mi_web/.

También, si hacemos `ls -l` de la carpeta `html` vemos sus permisos. Estos son importantes a la hora de intentar editar un fichero (ya que nos pedirá permisos de administrador) y por la seguridad de nuestra web.

!!! Note "Ejercicio"
    1. Consulta el fichero de configuración de Apache y cambia el document root a tu home en: /home/tu_usuario/mi_web/. Crea ahí un HTML.
    2. Reinicia Apache con `systemctl restart apache2` y si es necesario `systemctl reload apache2`. Comprueba si te sirve el HTML correcto.