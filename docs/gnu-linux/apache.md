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

=== "Otros"
    ```
    systemctl status httpd
    ```

Mira si aparece como habilitado (enabled) y en ejecución (active/running). En algunas distribuciones no está habilitado por defecto. Para habilitarlo y arrancarlo:

=== "Debian/Ubuntu"
    ```
    systemctl enable apache2
    systemctl start apache2
    ```

=== "Otros"
    ```
    systemctl status httpd
    systemctl enable httpd
    systemctl start httpd
    ```

### Probando apache
Las páginas web están en: **/var/www/html/**. Una vez instalado apache, puedes probar que funciona entrando en tu ip local desde un navegador (escribe "localhost" en el navegador web de la máquina donde has instalado el paquete).

## Parar o reiniciar el servicio
Si en algún momento queremos parar el servicio (de aquí en adelante se usará solo apache, si usas otra distribución será con httpd):

```bash
# Para el servicio
systemctl stop apache2

# Reinicia el servicio
systemctl restart apache2
```

