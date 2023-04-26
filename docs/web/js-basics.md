# Conceptos básicos de JavaScript

## Tipos de datos básicos
- **Numéricos**: 2, 4, 7.5, 12387321212, etc.
- **Textos**: "Hola", 'Hola', 'Buenos días'.
- **No definidos**: cuando no se establece ningún valor, este texto se marca como undefined.

## Funciones
Aquí se indicarán funciones que se usarán para la introducción a JavaScript. Las funciones tienen un nombre que indica lo que hacen por nosotros. Por ejemplo:

- **función mostrarEnPantalla:** mostraría en pantalla algo.
- **función escribirTexto:** escribirá algo en la pantalla.
- **función mostrarImagen:** mostrará una imagen en la pantalla.

Pero esto tiene un pequeño problema, ¿cómo indico que es lo que muestro? ¿qué imagen enseño? ¿con qué tamaño?

Bien, pues esto se indica entre paréntesis:

- **función mostrarEnPantalla("Hola :D!")**: mostraría en pantalla el texto entre comillas.
- **función mostrarImagen("https://google.com/gatos/gato1")**: mostrará en pantalla la imagen que hay en esa URL.
- **función mostrarImagen("https://google.com/gatos/gato1", 600, 600)**: muestra la imagen de la URL con 600 píxeles de ancho y 600 de alto").

Puedes crear funciones de la manera que prefieras.

### Funciones que ya vienen con Javascript
En Javascript existen ya funciones que hacen cosas por nosotros:

- **console.log("Texto"):** muestra en la consola de Javascript el texto que le indiques.
- **alert("Texto"):** muestra una alerta, esto es, un popup el texto que le indiques. Recuerda, si es un texto es entre comillas.
- **prompt("Pregunta"):** Puedes introducir un texto y pedir que el usuario haga algo.

## Variables

### Declaración (creación) de una variable
Puedes guardar textos o números en variables. La sintaxis para declarar variables es la siguiente:

- **let nombreVariable**

Si luego quiero guardar algo en ella solo tengo que usar el **operador =**:

- **nombreVariable = "valor"**

### Asignación de valores a una variable
El valor se pone entre comillas si es un texto, sin comillas si es un número. Por ejemplo, para un número sería:

- **nombreVariable = 17**

### Ejemplos
 Por ejemplo, si en un programa vasa usar mucho el número PI puedes guardarlo en una variable que se llame pi:

```js title="Variables"
let pi                  // Declaración de la variable
pi = 3.1415926535897    // Asignación de un valor a la variable (con el operador =)

```

### Ejercicios
 - Declara una variable *nombre* y asígnale tu nombre. Usa la función console.log(...) para mostrarlo en consola.
 - Declara una variable *apellidos* y asígnale tus apellidos. Usa la función console.log(...) para mostrarlo en consola.
 - Declara una variable *edad* y asígnale tu edad. Usa la función console.log(...) para mostrarlo en consola.
 - Modifica la variable *edad* declarada antes para que ahora almacene un 99 y muestralo con console.log.

### Declaración de variable y asignación en la misma línea
Es posible, cuando se declara una variable la primera vez, asignarle ya un valor. Hasta ahora lo habíamos hecho de la siguiente manera:

- **Declaración de la variable:** `let nombre`
- **Asignación de un valor:** `nombre = "Tania"`

Es posible hacer todo al mismo tiempo de la siguiente manera: `let nombre = "Tania"`, pero hay que tener cuidado ya que si luego se le quiere asignar un valor a esa variable ya no hay que poner el let (el let solo se pone la primera vez que se usa una variable).

## Constantes
Una constante es como una variable, solo que nunca más puede cambiar. Esto es, si yo creo una constante de *nombre* y le asigno mi nombre, luego no puedo asignarle otro (se producirá un error si lo intento).

### Ejemplos de constantes

```js title="Declaración de constantes" linenums="1"
// Declaro una constante que almacena el número PI
const numeroPi = 3.1416

// Muestro el número por pantalla
alert(numeroPi)

```

*El texto que aparece en las líneas 1 y 4 se llama comentario. No ejecuta ni crea nada nuevo, solo aporta información sobre el código*

### Ejercicios
Intenta lo siguiente:

```js title="Declaración de una constante sin asignación" linenums="1"
--8<-- "docs/ficheros/web/ejemplos-js/constants/constants-mistake-1.js"
```

1. ¿Funciona? Razona la razón por la que funciona o no funciona el programa anterior y donde falla.

## Ejercicios
Crea una carpeta "ejercicios-basicos-<tu_nombre>". Crea dentro un fichero index.html. Desde ese index.html vas a ir cambiando la referencia al fichero .js de cada ejercicio.

1. Crea un fichero básico index.html que enlace a un fichero javascript de nombre “ejercicio1-variables.js”. En ese fichero debes declarar una variable “num1” y una variable “num2”, asígnales valores y luego guarda la suma en una variable resultado que lo muestre por consola.
2. Haz lo mismo que en el anterior ahora en ejercicio2-variables.js, pero ahora que los reste y muestre el resultado por pantalla.
3. Copia el fichero ejercicio1-variables.js y llámale ejercicio3-sumastrings.js. Ahora, en lugar de darle los números escritos a mano tú mismo, vas a pedir al usuario que los introduzca el. Para pedir al usuario que introduzca un número puedes llamar a la función **prompt("Texto de la pregunta")**.
    - ¿El resultado es el esperado? ¿Qué está haciendo el programa? No te preocupes si no ocurre lo que esperabas, en los siguientes ejercicios veremos cómo arreglar este problema.
4. Copia el fichero **ejercicio3-sumastrings.js** a **ejercicio4-suma-numeros.js**.
    - En ese ejercicio deberías tener tres variables (una con el primer número, otra con el segundo y otra con el resultado). **Muestra un mensaje con el tipo de cada una**. Para ello se usa la **función typeof(valor)**. El mensaje que debería aparecer en consola es: “El tipo de la variable es: Number“ (si es que de verdad es un número … 🤔
    - Si todo ha ido correcto te pondrá que es un “String”, es decir, un texto. Prueba ahora a declarar una variable de nombre “prueba” y asignarle como valor un número. Haz lo mismo que en el apartado a) para ver de que tipo es (debería decirte que es un número).
5. Copia el fichero ejercicio3-sumastrings.js a ejercicio5-suma-numeros.js. Corrige el ejercicio anterior para que sume correctamente. La razón por la que no suma bien es porque cada número realmente es una texto o cadena de caracteres (string). Es decir, es un texto no un número de verdad. Para convertir un valor en numérico se usa la función Number(texto). Arregla el ejercicio para que sume bien ayudándote de la función Number(...).
6. En javascript existen varios tipos de datos (numéricos, texto, datos no definidos, valores nulos, etc.). En este ejercicio vamos a probarlos. Crea un fichero de nombre **ejercicio6-tipos-de-datos.js**.
    - Crea una variable variable1 y no le asignes ningún valor. Indica de qué tipo es con un mensaje de consola como el siguiente: “El tipo de la variable “variable1” es: …”.
    - Asígnale ahora (sin borrar nada de lo anterior) a variable1 el valor null (sin comillas. Mira de nuevo de que tipo es.
    - A las variables se le pueden asignar listas de cosas también (se hace usando corchetes []). Asígnale a variable1 lo siguiente tal cuál: [1, 2, 3, 17].
    - Muestra los datos del segundo elemento y del cuarto. Recuerda, los arrays empiezan en el elemento 0.
    - Crea un array de nombre alumnosTic que tenga los nombres del alumnado de clase:
        - Muestra el número de alumnos de clase.
        - Convierte el segundo elemento a mayúsculas.
        - Convierte el 5º elemento a minúsculas.
        - Haz que, aunque el array cambie de tamaño, siempre se muestre el penúltimo alumno.
7. Crea un script de nombre **ejercicio-7-funciones.js**. Crea una función que muestre por consola el mensaje “Hola mundo”. **La función debe llamarse “saludar”**. Crear una función no implica que esta se ejecute, así que no olvides hacerlo para probarla!
    - Indica, como en el ejercicio anterior usando typeof, de qué tipo es la función saludar.
8. Copia el script **ejercicio-7-funciones.js** con el nombre **ejercicio-8-funciones-parametros.js**.
    - Crea una función mostrarMensajeAlegre que muestre por pantalla un mensaje que le pases como parámetro y termine el mensaje con un emoticono contento. Pruébala.
    - Crea una función que reste dos números y muestre el resultado en el documento HTML (usando la función `document.write("texto")` para mostrarlo).
    - Crea una función que multiplique (operador *) **5 números pasados como parámetro** a la función y** devuelva (retorne) el total**. Prueba esa función y muestra el resultado por consola.
    - Crea una función de nombre **saludarPersona** que devuelva un mensaje de saludo a una persona con unos nombres y apellidos dados. La función debe recibir como parámetros:
        - Nombre de la persona.
        - Primer apellido.
        - Segundo apellido.
    - El resultado para "Juan", "Pérez", "López" debería ser algo así: <b>Hola Juan Pérez López. Bienvenido a casa &#128587 &#128149 !</b>. Puedes consultar como poner emoticonos [en este enlace](https://www.w3schools.com/charsets/ref_emoji.asp){:target="_blank"}.
9. Crea un fichero js ejercicio-9-grados.js que pida al usuario una cantidad en grados Celsius y la pase a grados Kelvin. El mensaje de respuesta deberá ser el siguiente: X grados Celsius son Y grados Kelvin y deberá mostrarse en el HTML de la página en letras grandes.
10. Crea un fichero js **ejercicio-10-grados.js** que haga lo mismo que el ejercicio anterior, **pero ahora usando una función convertirAKelvin**. Esa función debe encargarse **única y exclusivamente de la transformación de celsius a Kelvin.** Es decir, la función recibirá como parámetro unos grados Celsius y **devolverá** los Kelvin. La propia función no debe escribir en pantalla.
11. Crea un programa **ejercicio-11-ejercicios-funciones-variados.js**.
    1.  Crea un programa que calcule el volumen de una esfera y lo muestre en la página web. El programa deberá pedir al usuario que introduzca un radio y calcular el volumen. La fórmula del volumen es **V = 4/3 * PI * R^3**. Para hacerlo lo mejor posible crea una función que se ocupe de calcular el volumen a partir del radio pasado como parámetro.
    2. Crea una función que, pasado como parámetro un precio y un IVA, calcule el precio con IVA.
    3. Crea una función que, pasado un precio y un descuento como parámetros, devuelva el precio con descuento.
