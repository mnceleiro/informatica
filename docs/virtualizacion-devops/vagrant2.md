# Vagrant (parte II)


## Aprovisionamiento mediante scripts
### Ejercicio
Crea una carpeta al lado de las anteriores con el nombre "3-aprovisionamiento".

1. Ejecuta los comandos necesarios para actualizar el sistema (son 2).
2. Ejecuta un comando que instale el paquete "sl".
3. Ejecuta un comando que instale el paquete "vim".
4. Los comandos te han pedido todos confirmación, utiliza internet y el manual de Linux para **ejecutar esos comandos asegurándote de que NO te pidan confirmación**. Esto es, si tu instalas un paquete que no te pregunte si estás seguro.
5. Cada comando del punto 4 guárdalo en tu ordenador en un fichero de nombre "script-provision.sh".
6. Añade como primera línea en ese fichero de texto "#!/bin/bash".

Si has hecho bien todos los pasos anteriores tendrás un fichero de texto con una serie de comandos. Has creado tu primer script. Guarda ese script en la carpeta "3-aprovisionamiento" (al lado de tu Vagrantfile). Posteriormente haz que el Vagrantfile ejecute ese script (puedes forzar el aprovisionamiento con vagrant up --provision).

!!! Note "Nota"
    Este ejercicio se diferencia del anterior realizado en que en el anterior ejecutábamos una única línea de código directamente. En este caso tenemos un fichero con varias líneas y queremos indicar en el Vagrantfile que se ejecute ese fichero. Esta forma es mucho más ordenada.


TODO: Se ampliará este tutorial. A partir de este momento necesitas saber algo de GNU/Linux y tener conceptos de scripting en BASH. Si no sabes usar GNU/Linux con fluidez o no sabes hacer scripts puedes ir al apartado de "GNU/Linux --> scripting" de esta misma página.