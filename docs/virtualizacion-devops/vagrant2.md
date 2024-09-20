# Vagrant (parte II)
A partir de este momento necesitas saber algo de GNU/Linux y tener conceptos de scripting en BASH. Si no sabes usar GNU/Linux con fluidez o no sabes hacer scripts puedes ir al apartado de "GNU/Linux --> scripting" de esta misma página.

## Aprovisionamiento mediante scripts

### Ejercicio
Crea una carpeta al lado de las anteriores con el nombre "3-aprovisionamiento".

1. Ejecuta comandos para actualizar el sistema.
2. Ejecuta un comando que instale el paquete "sl".
3. Ejecuta un comando que instale el paquete "vim".
4. Los comandos te han pedido todos confirmación, utiliza internet y el manual de Linux para que NO te pidan confirmación. Esto es, si tu instalas un paquete que no te pregunte si estás seguro.
5. Cada comando del punto 4 guárdalo en tu ordenador en un fichero de nombre "script-provision.sh".
6. Añade como primera línea el texto "#!/bin/bash".

Si has hecho bien todos los pasos anteriores habrás creado tu primer script. Guarda ese script con tu Vagrantfile en la carpeta "3-aprovisionamiento". Posteriormente haz que el Vagrantfile ejecute ese script.

!!! Note "Nota"
    Este ejercicio se diferencia del anterior realizado en que en el anterior ejecutábamos una línea de código directamente. En este caso tenemos un fichero con varias líneas y queremos indicar en el Vagrantfile que se ejecute ese fichero. Esta forma es mucho más ordenada.