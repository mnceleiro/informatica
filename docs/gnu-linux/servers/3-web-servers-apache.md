# Actividad guiada: Instalación de servidores web en entornos Windows y GNU/Linux

Hemos visto anteriormente donde está la configuración por defecto de Apache (donde se indica el DocumentRoot del mismo), esto es en el fichero `000-default.conf`.

Ahora, ¿qué podemos hacer si queremos tener varios sitios (p. ej: 3 páginas web) en el mismo servidor? Para eso utilizamos **VirtualHosts**.

### Configurando un VirtualHost
Vamos a configurar nuestro primer Virtualhost. Para ello, en la carpeta `/etc/apache2/sites-available` donde tenemos el `000-default.conf` crearemos otro fichero (yo le he llamado mi-web-1.conf).
```

```