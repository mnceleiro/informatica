## Configuración de un dominio gratuito y HTTPS (OPCIONAL)
Bien, hasta ahora hemos instalado servidores web y nos hemos conectado a ellos de forma no segura (por HTTP, donde el tráfico no va encriptado).
Vamos a crear nuestra propia página, en la que podamos conectarnos de forma segura mediante **HTTPS** y con un **dominio propio** (sin tener que usar la IP).

Para conseguir registrar un dominio gratuito utilizaremos **NO-IP**: [https://www.noip.com/es-MX](https://www.noip.com/es-MX).
Para obtener y configurar automáticamente un **certificado SSL**, usaremos **Certbot** con **Let’s Encrypt**.

¡Empezamos!

### Parte I: configurando Apache de forma básica en AWS

1. Crea una nueva máquina con **Debian 12** en AWS.
3. Cambia el nombre del equipo para que se llame **"produccion"**.
4. Instala **Apache2** en la máquina.
5. Elimina el contenido del `index.html`.
   Crea un **HTML sencillo** con un `<head>` y un `<body>`, codificación **UTF-8**, idioma español y un **`<h1>` con tu nombre y apellidos**.
6. Configura el **reenvío de puertos** para que todo funcione correctamente.

### Parte II: configurando un dominio

Tenemos AWS instalado y los puertos abiertos, pero para poder acceder siempre a la página sería interesante tenerla asociada a un **nombre que puedas recordar** en lugar de una **IP numérica** (esto es lo que se llama un **dominio**).

1. Entra en [www.noip.com/es-MX](https://www.noip.com/es-MX) y **regístrate**.
   Esta página te permite registrar un **dominio gratuito**.
2. Configura un **nuevo hostname** con tu **las tres primeras letras de tu nombre y tres primeras de tu apellido** (por ejemplo, para Rosa López sería: `roslop.ddns.net`) y **asócialo con la IP** del servidor web alojado en AWS.
3. Una vez hecho esto, deberías poder acceder ya con el nuevo dominio.
   Por ejemplo: para `roslop.ddns.net` debería funcionar correctamente y mostrar la página.

### Parte III: securizando el servidor web con SSL/TLS

Primero de todo, en la configuración del **VirtualHost** que viene por defecto en Apache, añade lo necesario para habilitar HTTPS.

Vamos a **instalar un certificado HTTPS** en el servidor.
Esto sería muy tedioso de hacer manualmente, pero en la práctica es sencillo gracias a **Certbot**.

1. Entra en la página web de Certbot, ve a la sección **“Instructions”**, y sigue las instrucciones para instalar un **certificado SSL en Ubuntu**.
2. Una vez termines de hacer todo lo indicado en la documentación, **prueba a entrar de nuevo** en tu página web:

   * Añadiendo delante `https://`
   * Y también con `http://`
     La segunda (HTTP) debería estar **deshabilitada**, y la primera (HTTPS) **funcionar correctamente**.

**Opcional:** investiga en internet cómo crear un script para actualizar el certificado cada 3 meses.

* Crea un **script** con los comandos de Certbot que hayas usado.
* Añádelo al **cron** para que se ejecute automáticamente.