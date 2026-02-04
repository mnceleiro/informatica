# Introducción al lenguaje Kotlin

Puedes usar IntelliJ IDEA o [https://play.kotlinlang.org](https://play.kotlinlang.org){target="_blank"} para probar código.

## Sintaxis básica
### Constantes
Para definir una constante en kotlin se usa la palabra clave `val` (value o valor). Estamos creando un "valor" constante:

Todo lo siguiente es inmutable:

```kotlin
fun main() {
    val nombre = "Marcos"
    val edad = 38

    //val edad = 39 // ERROR si descomento esta línea: no puedo modificarlo ya que es una constante!

    // Muestro el nombre por pantalla
    println(nombre)

    // Muestro la edad por pantalla
    println(edad)
}

```

### Función de imprimir por pantalla (print y println)
- La función `print(mensaje)` nos permite mostrar por pantalla sin salto de línea.
- La función `println(mensaje)` nos permite mostrar por pantalla (con salto de línea final).

```kotlin
fun main() {
    println("Esto es un mensaje.")

    val mensaje = "Hola mundo"

    println(mensaje)

    println()
    println()

    print("Hola")
    print(" ")
    println("mundo")
}

```

Podemos concatenar los mensajes con el operador "+" (igual que haciendo una suma de números):

```kotlin
fun main() {
    val nombre: String = "Lucía"
    val edad: Int = 17

    println("El nombre es: " + nombre)
    println("La edad es: " + edad)

    println()

    println("El nombre es " + nombre + " y su edad es: " + edad + " años.")
}
```

Otra manera más sencilla (si eres nuevo en programación te recomiendo practicar antes la anterior) es usar el caracter `$`.

```kotlin
fun main() {
    val nombre: String = "Lucía"
    val edad: Int = 17

    println("El nombre es: $nombre")
    println("La edad es: $edad")

    println()

    println("El nombre es $nombre y su edad es: $edad años.")
}
```

Aunque esta forma es más simple y entendible, asegúrate también de estar adaptado a la primera si estás empezando a programar. Yo las variaré a lo largo de los ejemplos.

### Variables: declaración y asignación
Para declarar variables se usa la palabra clave `var`. La sintaxis es la siguiente:

```scala
// Declaración
var nombreVariable: Tipo

// Asignación
nombreVariable = Valor

// Declaración y asignación todo a la vez
var nombreVariable = Valor // No haría falta el tipo, ya que al asignarle el valor directamente ya lo infiere
```

Veámoslo con un ejemplo real:

```kotlin
fun main() {
    // Si declaro algo pero no asigno un valor hay que ponerle el tipo de dato que voy a usar!
    var numero: Int

    // Asigno despues
    numero = 10

    // Ahora no hace falta poner tipo, porque ya asigno un "entero" (Int). Por tanto Kotlin ya que su tipo es Int.
    var otroNumero = 38

    // Cambio la edad (puedo, ya que es una variable y puedo modificarla)
    otroNumero = 39

    println("El primer numero es: " + numero + " y el segundo numero es: " + otroNumero + ".");
}
```

Para crear variables a las que no les asigno nada tengo que indicar su tipo (Int, String, Long, Float, Double...). En el caso de String no te funcionará (pronto lo veremos).

#### Ejercicio
Intenta hacer el siguiente ejercicio (cíñete a lo que pide cada comentario y resuelve debajo del mismo):
```kotlin
fun main() {
    // 1. Declara una variable "ciudad" y asígnale tu ciudad de nacimiento


    // 2. Muestra la ciudad por pantalla


    // 3. Crea una constante "añoActual" de tipo entero.


    // 4. Asígnale a la variable el año en el que estamos: 2026.


    // 5. Muestra por pantalla el año actual.


}

```

Bien, ya has interiorizado un poco la declaración y asignación de variables en Kotlin. Vamos a ver ahora como tratar los nulos.

### Variables: seguridad ante nulos
El lenguaje Kotlin es un lenguaje seguro ante nulos. **Por defecto, en sus variables, no permite valores nulos**. Esta es la razón por la que esto no funciona:

```kotlin
fun main() {
    // Ninguna de estas líneas es válida, ya que las variables no pueden tener valores nulos
    var miCiudad: String
    miCiudad = ""

    var ciudad2: String = null
    val ciudad3: String = null
}

```

!!! Failure "Los tipos en Kotlin no son nullables"
    Ningún tipo de dato en Kotlin puede ser nulo. Si queremos que un tipo de dato pueda ser nulo se hace con el caracter "?". Por ejemplo: `Int?`, `Double?`, `String?`...

**No se permiten valores nulos en Kotlin por defecto**. Pero hay una manera de decirle a Kotlin que queremos dar un permiso especial a la variable para que sí contenga valores nulos (podemos pensar que le damos consentimiento):

- Operador de tipo nullable: ?
- Operador de llamada segura: ?.
- Operador de aserción de nulos: !!

Veamos para que sirven estos operadores. Empecemos por el operador "?":

```kotlin
fun main() {
    // No funciona: "Property must be initialized."
    var ciudad: String

    // No funciona: "Null cannot be a value of a non-null type 'String'."
    var ciudad2: String = null
}

```

**"Null cannot be a value of a non-null type 'String'**. Esto significa que no solo `ciudad` es de tipo `String`, sino que en Kotlin, **todos estos tipos son NO NULLABLES (vale para cualquier otro tipo de dato)**.

¿Cómo hacemos entonces que funcione? Pues **tenemos que decirle que la variable no solo es de tipo String, sino que es de tipo "String nullable"**. Esto se escribe como "String?":

```kotlin
// FUNCIONA! Le indico que es un String nullable
fun main() {
    var ciudad: String? = null

    println("Ciudad tiene el valor: " + ciudad)

    ciudad = "Lugo"

    println("Ahora ciudad tiene el valor: " + ciudad)
}
```

!!! Note "Ejercicio"
    Modifica los códigos de los 2 programas anteriores que no funcionaban añadiéndoles al tipo el operador "?". Con esto deberían compilar.

### Operador de llamada segura: `?.`

En el ejemplo anterior vemos que `ciudad` ya no es de tipo `String`, sino que es de tipo `String?`. Para hacer llamadas a métodos de un objeto nullable, tenemos que usar el operador de llamada segura: "?.". Por ejemplo:

```kotlin
// FUNCIONA! Le indico que es un String nullable
fun main() {
    var ciudad: String? = "Lugo"

    println("Longitud del string: " + ciudad?.length)
}
```

!!! Note "Ejercicio"
    1. Ejecuta el código anterior sin usar el ?. (solo .). Observarás que saltará un error. Luego vuelve a dejarlo funcionando.
    2. Modifica el programa para que en lugar de asignar Lugo a `ciudad`, esta sea nula. Después, piensa lo siguiente:
       1. ¿Qué ocurriría en Java si ejecutas la línea del println siendo nulo el valor de "ciudad"?
       2. ¿Qué ocurre aquí al ejecutarlo?

En Java, si ejecutas un método sobre cualquier objeto nulo. (por ejemplo: NULL.toString()) saltará una NullPointerException(). Los tipos con "?" en Kotlin permiten evitar esta excepción.

### Operador !!
**Este operador no está recomendado**, pero si quisieses ejecutar código como lo harías en Java (haciendo que Kotlin ignore la posible NullPointerException y te permita compilar el código), puedes usar el operador `!!`:

```kotlin
fun main() {
    var ciudad: String? = "Lugo"

    println("Longitud del string: " + ciudad!!.length)
}
```

!!! Note "Ejercicio"
    Prueba a cambiar el valor de ciudad a nulo y observa lo que ocurre. Es lo mismo que ocurriría en un programa cualquiera en Java o C#, ¿entiendes ahora el valor de estos operadores?


### Smart casting
Si haces una comprobación de nulos antes de la llamada a las propiedades del objeto (en el caso anterior a `length`) ya no haría falta usar `?.`. Esto se denomina *smart casting*.

```kotlin
fun main() {
    var ciudad: String? = null

    // Comprobamos si la ciudad tiene un valor: en ese caso ya no necesito el operador "?."
    if (ciudad != null) {
        println("Longitud del string: " + ciudad.length)
    }
}
```


### Operador Elvis `?:`
Esto es lo último que mostramos de ejemplo relacionado con los nulos.

```kotlin
fun main() {
    val nombre: String? = null

    val longitud = nombre?.length ?: 0 // Si el resultado es nulo devuelve 0

    println("Longitud: $longitud")
}
```

La variable `longitud` necesita coger un valor, lo que hace `?:` es que, si el operando de la izquierda es NO NULO, entonces lo usará, pero si es NULO devolverá 0.

!!! Note "Ejercicio"
    Prueba a cambiar el valor anterior de "nombre" a null y ejecuta el código.

### Función de leer teclado: readln()
Si quieres leer de teclado puedes usar la función `readln()`. Posteriormente, puedes convertir los datos obtenidos en lo que quieras con las [funciones de conversión de tipos](https://codesignal.com/learn/courses/getting-started-with-kotlin/lessons/mastering-primitive-data-type-conversion-in-kotlin){target=_blank}: `toInt()`, `toDouble()`, `toString()`...

```
val cadena = readln()
val numero = readln().toInt()
```

!!! Warning "La función readln() no funciona en esta web"
    La función `readln()` no funcionará en los fragmentos de código mostrados en esta web. Si quieres usarla, tendrás que hacer el programa en tu equipo.

## Funciones
Las funciones es el concepto más importante que tienes que entender en programación funcional y para desarrollar interfaces en Android con Compose.

### Sintaxis básica
Esta es la sintaxis básica de las funciones:
```kotlin
fun nombreFuncion(param1: Tipo1, param2: Tipo2, ...): TipoRetorno {
    // cuerpo de la función
    return valor
}
```

- `fun` → palabra clave para declarar función
- `nombreFuncion` → identificador de la función
- `(param1: Tipo1, ...)` → **parámetros** con nombre y tipo
- `: TipoRetorno` → **tipo de retorno** de la función (obligatorio si devuelve algo)
- `{ ... }` → **cuerpo de la función**
- `return` → devuelve un valor (obligatorio si el tipo de retorno no es `Unit`)

Veamos algunos ejemplos:
```kotlin

// Funcion que recibe 2 enteros como parámetro y devuelve otro entero
fun sumar(a: Int, b: Int): Int {
    return a + b
}

fun main() {
    val num1 = 10
    val num2 = 20

    // Podemos llamar a la función dentro de un template string con ${}
    println("La suma de $num1 y $num2 es ${sumar(num1, num2)}.")
}
```

Otro ejemplo ahora de funciones que no devuelven nada (Unit):

```kotlin
// Funcion que no devuelve nada (Unit)
fun imprimirSaludo(nombre: String): Unit {
    println("Hola $nombre")
}

// Escribir unit es opcional
fun imprimirSaludo2(nombre: String) {
    println("Hola $nombre")
}

fun main() {
    imprimirSaludo("Lucía")
    imprimirSaludo2("Ángel")
}
```

### Funciones como expresiones
Al crear funciones podemos no escribir las llaves "{}" ni el "return". Es una forma más compacta y simple de escribir funciones pequeñas:

```kotlin
// Forma normal
fun saludarVersionNormal(nombre: String): String {
    return "Hola $nombre"
}

// Forma compacta (función como expresión)
fun saludarVersionCorta(nombre: String) = "Hola $nombre"
```

La última forma es más simple. En ella ignoramos el tipo devuelto (ya supone que es un String), el return y las llaves. Las funciones se pueden definir de la forma normal (imperativa) o como expresiones. En Kotlin es muy habitual usarlas en forma de expresiones.

!!! Note "Ejercicio"
    1. Modifica el código anterior para que tenga una función *main* donde pruebes ambas versiones.
    2. Crea una función como expresión "saludar(nombre) que diga: "Hola <\nombre>".

### Parámetros por defecto
Se pueden pasar parámetros por defecto a las funciones. En Kotlin puedes darle un valor inicial a los parámetros.  Si el usuario **no pasa nada**, se usa ese valor.

```kotlin
fun saludar(nombre: String = "Invitado") = "Hola $nombre"

fun main() {
    // Llamadas válidas
    println(saludar())           // usa "Invitado"
    println(saludar("Marcos"))   // usa "Marcos"
}
```

En caso de tener varios parámetros por defecto :
```kotlin
fun crearUsuario(
    nombre: String,
    edad: Int = 0,
    esAdmin: Boolean = false
) {
    println("Usuario: $nombre, edad $edad, admin: $esAdmin")
}

fun main() {
    // Llamadas válidas
    crearUsuario("Marcos")
    crearUsuario("Ana", 25)
    crearUsuario("Luis", 30, true)
}
```

!!! Tip "Parámetros por defecto en compose..."
    En Android, existen funciones como `Text("Hola mundo")` que reciben un texto y lo muestran. Estas funciones no reciben solo 1 parámetro sino muchísimos más que tienen asignado un valor por defecto (alineación del texto, fuente, tamaño...). Por esta razón lo anterior funciona, pero podemos reutilizar la función pasando muchas variedades distintas de parámetros.

### Parámetros nombrados
Se pueden pasar parámetros por su nombre (en ese caso no importaría el orden que uses para pasarlos):

```kotlin
fun restar(a: Int, b: Int) = a - b

fun main() {
    // Llamada típica (pasando los parámetros por orden)
    val resta = restar(10, 3)

    // Llamada con los parámetros nombrados
    val resta2 = restar(a = 10, b = 3)

    println("El resultado de la resta es: $resta2")
}
```

Puedo pasar los parámetros desordenados siempre y cuando sean nombrados:

```kotlin
fun crearUsuario(
    nombre: String,
    edad: Int = 0,
    esAdmin: Boolean = false
) {
    println("Usuario: $nombre, edad $edad, admin: $esAdmin")
}

fun main() {
    // TODO: llama a crear usuario de 2 formas distintas: 
    // 1. Pasando los tres parámetros por posición.
    // 2. Pasando solo dos parámetros de la manera que quieras.
    // 3. Pasando los parámetros desordenados.

}
```

!!! Note "Ejercicio"
    Completa el *main* anterior.


### Parámetros mezclados por posición y por nombre
Se pueden mezclar los parámetros por posición y nombre. Eso sí, una vez pasas el primer parámetro por nombre ya no puedes seguir pasando por posición.

Como ejemplo, te muestro dos llamadas (una que funcionaría y otra que no.):

```
// Funciona
crearUsuario("Marcos", esAdmin = true)

// No funciona
crearUsuario(nombre = "Marcos", 25)
```

!!! Note "Ejercicio"
    Prueba las llamadas anteriores en el *main* del código anterior. Asegúrate de entender por qué funcionan o no lo hacen.

### Paso de parámetros en Android con Compose
Usar parámetros nombrados (y los valores por defecto que ya hemos visto) son muy prácticos para diseñar interfaces:
```
Text(
    text = "Hola",
    maxLines = 1
)
```

!!! tip "Interfaces en Android con funciones"

    La función Text anterior es un ejemplo de como podríamos mostrar un texto en Android que no permita más de 1 línea. Lo estamos llamando usando parámetros nombrados, ¿te fijas en que es muy legible?

## Clases y objetos
TODO

## Data classes
Las data classes nos autogeneran los métodos toString() equals() hashCode() y copy(). Se crean de la siguiente forma:

```kotlin
// Este data class genera: toString() equals() hashCode() y copy(). En android es importante que los modelos sean inmutables (val)
data class Usuario(
    val nombre: String,
    val edad: Int
)

fun main() {
    val user = Usuario("Daniel", 17)

    println(user)
}
```

Esta clase tiene automáticamente todos los *getters* y *setters*, el *toString()*, *copy()*, *equals()* y *hashCode()*.

## Colecciones
### Arrays
Permite modificar los valores, pero **no puedes cambiar el tamaño del array**. Se usan en estos casos:

- Cuando necesitas interoperabilidad con Java.
- Cuando el tamaño no va a cambiar.
- Cuando buscas rendimiento un poco mayor que una lista.

```kotlin
fun main() {
    // Creamos un array de números
    val numeros = arrayOf(1, 2, 3)

    // Cambio el número de la segunda posición por un 10
    numeros[1] = 10

    // Imprimo el número de la segunda posición
    print(numeros[1])

    // Esto no funcionaría (no puedo añadir otro número al array)
    // numeros += 4     // no se puede: no crece
}
```

Las listas son más prácticas y habituales en Android. No usarás muchos arrays de este tipo.

### Listas inmutables (List<T\>)
Existen **listas mutables** (el tipo es (MutableList<T\>)) y **listas inmutables** (el tipo es (List<T\>)). Las inmutables se pueden hacer con `listOf`. Se usan cuando:

- Para datos que no deben modificarse
- Ideal para modelos, configuraciones, constantes
- En Kotlin y Android lo más habitual es usar listas inmutables.

```kotlin
fun main() {
    val letras: List<String> = listOf("a", "b", "c")
    letras.add("d")  // error
}
```

!!! Note "Ejercicio"
    Intenta modificar el *main* anterior para que `letras.add("d")` funcione. Para ello tendrás que **convertir la lista en "mutable"** (se hace con `mutableListOf() en lugar de listOf()`). 
    
    Recuerda cambiar también el tipo de la lista (o quitarlo y dejar que lo infiera Kotlin).


### Listas mutables
Se puede añadir, eliminar y modificar.

```kotlin
fun main() {
    val letras = mutableListOf("a", "b", "c")
    letras.add("d")           // Funciona
    letras.remove("b")        // Funciona
    letras[0] = "z"
}
```

### Métodos de listas
A continuación de muestran varios ejemplos de métodos que puedes usar sobre una lista:

```kotlin
fun main() {
    // Declaración de arrays y listas
    val arr = arrayOf(10, 20, 30)

    val listaInmutable = listOf("A", "B", "C")

    val listaMutable = mutableListOf("A", "B", "C")
    listaMutable.add("D")

    // Acceso a elementos
    val nombres = listOf("Ana", "Luis", "Eva")

    // Acceso por índice
    println("Nombre en posición 2: ${nombres[1]}")   // Luis

    // Usando otros métodos útiles
    val primerNombre = nombres.first()  
    val ultimoNombre = nombres.last()
    val tamanhoLista = nombres.size

    println("Primer nombre: $primerNombre.")
    println("Último nombre: $ultimoNombre.")
    println("Tamaño de la lista: $tamanhoLista.")

    // Añadido y eliminación de elementos (para listas mutables)
    val nums = mutableListOf(1, 2, 3)
    nums.add(4)
    nums.remove(2)
    nums.removeAt(0)
    nums.clear()          // deja la lista vacía
}
```

## Iteración sobre listas con bulces
```kotlin
fun main() {
    val numeros = mutableListOf(1, 2, 3)

    // Iteración sobre listas
    for (n in numeros) {
        println(n)
    }

    for ((indice, valor) in numeros.withIndex()) {
        println("$indice -> $valor")
    }

    for ((indice, valor) in numeros.withIndex()) {
        println("$indice -> $valor")
    }

    numeros.forEachIndexed { index, value ->
        println("$index : $value")
    }
}
```

## Iteración sobre listas usando programación funcional
```kotlin
fun main() {
    // Métodos de alto nivel
    val lista = listOf(1, 2, 3, 4, 5)

    val listaPor2 = lista.map { it * 2 }           // [2, 4, 6, 8, 10]
    println("Lista multiplicada por 2: $listaPor2")

    val listaPares = lista.filter { it % 2 == 0 }   // [2, 4]
    println("Lista de pares: $listaPares")

    val listaOrdenada = lista.sorted()                 // [1, 2, 3, 4, 5]
    println("Lista ordenada: $listaOrdenada")

    val hayElementosMayoresQue3: Boolean = lista.any { it > 3 }  // true
    println("Hay elementos mayores que 3 en la lista? $hayElementosMayoresQue3")
    
    val todosSonPositivos: Boolean = lista.all { it > 0 }           // true
    println("Todos son positivos? $todosSonPositivos.")
    
    val sumaTotal = lista.sum()
    println("Suma de todos los valores de la lista: $sumaTotal")
}
```