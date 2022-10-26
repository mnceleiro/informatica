## Creación de scripts
Para crear un script en BASH creamos un fichero con el nombre que queramos y la extensión **.sh** y le damos permisos de ejecución (u+x):

```echo "" > helloworld.sh```

Esto crea un fichero helloworld.sh al que deberíamos darle también permisos de ejecución. Para dar permisos usamos el comando chmod y podemos hacerlo de dos maneras distintas:

`chmod u+x helloworld.sh`

o

`chmod 764 helloworld.sh`

Ejemplo de realización de la tarea de creación de script y permisos de ejecución para el usuario:
![Comando chmod](../images/gnu-linux/chmod.png)

### Primer script
Para empezar, nuestro primer script mostrará en pantalla solamente la línea:

`Hola mundo`

Para ello, editamos el script con nuestro editor preferido (p. ej: vim o nano) y añadimos lo siguiente:

```
#!/bin/bash

echo "Hola mundo."
```

#### Ejecución
Para ejecutar el script podemos usar cualquiera de los siguientes comandos:

`./helloworld.sh`

`bash helloworld.sh`

El resultado debería ser el siguiente:
![Script hola mundo](../images/gnu-linux/hello-world.png)  
## Variables
Una variable es un sitio en memoria para guardar información. Un ejemplo de creación de una variable y asignación de un número a ella sería el siguiente:

`EDAD=35`

Veamoslo con un script de ejemplo:

```
Ejercicio: crear una variable "NOMBRE" que almacene el nombre de una persona. Después, mostrar por pantalla "Tu nombre es ________."

# Fichero: variables.sh
----------------------------

#!/bin/bash

NOMBRE="Marcos"
echo "Tu nombre es: NOMBRE"

```

Resultado de la ejecución (no nos sale como queremos):
![](../images/gnu-linux/variables-1.png)  

¿Es esto lo que esperábamos? Efectivamente, el echo está funcionando como debe y el terminal nos muestra lo que le indicamos. Pero, ¿como podemos hacer que el echo nos interprete la variable **NOMBRE** e indique, por tanto, lo que hemos almacenado en la variable?

Bien, para hacer **que la palabra "NOMBRE" se interprete como una variable, solo tenemos que ponerle delante el caracter de DOLAR ($):

```
Ejercicio: crear una variable "NOMBRE" que almacene el nombre de una persona. Después, mostrar por pantalla "Tu nombre es ________."

# Fichero: variables2.sh
----------------------------

#!/bin/bash

NOMBRE="Marcos"
echo "Tu nombre es: $NOMBRE"

```

Resultado de la ejecución:
![](../images/gnu-linux/variables-2.png)

Ahora sí funciona correctamente. El valor que le hemos asignado a la variable es "Marcos", pero si lo cambiamos con otro la frase también cambiará.

Probemos con otro ejercicio:

```
Ejercicio: crear una variable "NOMBRE" que almacene el nombre de una persona. Después, mostrar por pantalla "Tu nombre es ________." Después, haz que el programa espere dos segundos y muestre: "Te has cambiado el nombre y ahora es "Mark".

# Fichero: variables3.sh
----------------------------

#!/bin/bash

NOMBRE="Marcos"
echo "Tu nombre es: $NOMBRE"

sleep 2

NOMBRE="Mark"
echo "Ahora tu nombre es: $NOMBRE"
```

Resultado:

![](../images/gnu-linux/variables3.png)  


*Para saber más: además de "VARIABLE" existe también la definición de "CONSTANTE". Una constante es lo mismo que una variable, solo que esta no puede volver a cambiarse a lo largo del programa.*

