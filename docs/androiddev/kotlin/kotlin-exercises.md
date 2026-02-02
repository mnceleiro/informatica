# Ejercicios de Kotlin
Crea un nuevo proyecto en IntelliJ IDEA con Kotlin y resuelve los siguientes ejercicios. En los ejercicios puedes ignorar las excepciones de momento (a no ser que se pida explícitamente).
## Básicos (tipos, operadores y funciones)

### Suma dos números
Crea un programa que:

- Cree una constante `n1` con el valor: 17.
- Cree una constante `n2` con el valor: 12. 
- Crea una variable `suma` de tipo entero.
- Asigna (en otra línea diferente a la declaración de la creación de la variable) a la `suma` el valor de sumar `n1` y `n2`.
- Debe sacar un mensaje que ponga: "La suma de n1 y n2 es: suma". Usa el operador `+` para concatenar la frase y los valores de las variables. 

??? success "Ver solución"

    ```kotlin
    fun main() {
        // NO es necesario poner el tipo, ya que ya estoy asignando un entero
        val n1 = 17 
        val n2 = 12
        
        // No puedo poner la suma como "val", ya que implicaría que tengo que darle un valor constante.
        var suma: Int
        
        suma = n1 + n2
        
        println("La suma de " + n1 + " y " + n2 + " es " + suma)
    }
    ```

### Pedir números al usuario
1. Repite el ejercicio anterior, pero ahora los números se pedirán al usuario. Puedes usar la función `readln()` y las [funciones de conversión de tipos](https://codesignal.com/learn/courses/getting-started-with-kotlin/lessons/mastering-primitive-data-type-conversion-in-kotlin): `toInt()`, `toString()`, etc.
2. Además, el mensaje lo usarás sin concatenarlo con el operador `+`. Para concatenar strings puedes usar `$variable` dentro del mensaje. Por ejemplo: `println("Hola $nombre")`

### Variables que pueden ser nulas
1. Crea una variable "mensaje" con valor null (no con valor "null" tipo string, sino nulo de verdad). Para ello usa el operador "?".
2. Muestra el tamaño del array (length). Para que te compile tendrás que utilizar el operador de llamada segura `?.`.
3. Prueba lo mismo pero ahora, en lugar de con el operador `?.`, usando el operador !!.

### Englobar los ejercicios anteriores en funciones
Introduce los ejercicios anteriores de **sumar números** en funciones:

- La primera será `sumaNumeros(a, b)` que hará todo el ejercicio.
- La segunda (donde pides tu al usuario) será `sumaNumeros()` y englobará todo el ejercicio nuevamente. La petición de números al usuario se hará en otra función `pedirEntero(): Int`.
- Llama a las funciones desde el `main` y comprueba que siguen funcionando.

??? success "Ver varias posibles soluciones"

    ```kotlin
    fun pedirNumeroYComprobarSiNegativoPositivoOCerov1() {
        print("Introduce un número: ")
        val numero = readln().toInt()

        if (numero > 0) {
            println("El número $numero es positivo.")

        } else if (numero < 0) {
            println("El número $numero es negativo.")

        } else {
            println("El número es cero")
        }
    }

    fun pedirNumeroYComprobarSiNegativoPositivoOCerov2() {
        print("Introduce un número: ")
        val numero = readln().toInt()

        val descNumero = if (numero > 0) "positivo" else if (numero < 0) "negativo" else "cero"

        println("El número $numero es $descNumero.")
    }

    fun pedirNumeroYComprobarSiNegativoPositivoOCeroConWhen() {
        print("Introduce un número: ")
        val numero = readln().toInt()

        when {
            numero > 0 -> println("El número $numero es positivo.")
            numero < 0 -> println("El número $numero es negativo.")
            else -> println("El número es cero.")
        }
    }

    fun main() {
        //pedirNumeroYComprobarSiNegativoPositivoOCerov1()
        //pedirNumeroYComprobarSiNegativoPositivoOCerov2()
        pedirNumeroYComprobarSiNegativoPositivoOCeroConWhen()
    }
    ```

### Obtener longitud de un string nullable (operador elvis)
Crea una función `getLongitud` que devuelva la longitud de la cadena pasada como parámetro. La cadena será de tipo `String?`. Usa el operador elvis.

### Mostrar un título nullable (operador elvis)
Dado: `var titulo: String? = null`, queremos mostrar un texto seguro: `Título: <value>`. Si es null aparecerá en pantalla: `Título: (sin título)`. Hazlo con `?:`

### Función mostrarNombre()
Crea una función mostrarNombre que muestre por pantalla el nombre pasado como parámetro (que será un string que puede ser nulo). No uses el operador `!!`. Pruébala.

### Sumar dos números y devolver el resultado
Define una función sumar que sume 2 números (y devuelva el resultado). Hazlo tanto **de forma estándar** (forma normal, con llaves) y **como una expresión** (sin llaves).

### Presentarse con nombre y edad
Escribe un código Kotlin que tenga:
- Una variable `val` con tu nombre.
- Una variable `var` con tu edad. Haz que la edad pueda ser nula.
- Una función `presentarse()` que devuelva un string del tipo: `Me llamo <nombre> y tengo <edad> años`.

## Condicionales y bucles
### Clasificar números
1. Escribe una función que pida un número al usuario y determine si es positivo, negativo o cero. Además, indica si es par o impar (en caso de no ser cero).
2. Modifica el programa para que use `when` en lugar de `if-else`.

### Tabla de multiplicar
Crea una función que genere la tabla de multiplicar de un número pasado como parámetro (del 1 al 10). Usa un [bucle for](https://www.programiz.com/kotlin-programming/for-loop) y muestra el resultado en formato: "5 x 3 = 15"

## Funciones (parámetros nombrados y por defecto)
### Mostrar mensaje y veces a mostrarlo
1. Escribe una única función `mostrarMensaje` que reciba dos parámetros: el mensaje y el número de veces que debe aparecer (por defecto será 1 vez). 
2. Debes llamar a la función de tres formas diferentes:
   - Solo pasando el mensaje.
   - Pasando el mensaje y el número de veces.
   - Usando parámetros nombrados (named parameters).

### Función que muestra datos de un producto
Crea una función `verDatosProducto` que reciba: nombre (string), precio (double), stock (entero) y categoría (string). Stock y precio tendrán 0 a valor por defecto y la categoría será "global" por defecto. Haz las siguientes llamadas:

- Solo nombre.
- Nombre y precio.
- Nombre y stock usando parámetros nombrados.
- Nombre y categoría (saltando precio y stock).
- Todos los parámetros, algunos por posición y otros nombrados.

### Crear un botón
Crea una función `crearBoton` que reciba:

- Un texto.
- Un color (por defecto "negro").
- Un borde (booleano).
- Un tamaño (por defecto 14).

Llámala de estas formas:

- Solo el texto.
- Texto y tamaño.
- Texto, color y borde en el orden que quieras.
- Texto y borde (sin tocar el color y el tamaño).
- Texto, tamaño, color y borde en diferente orden.

## Funciones lambda
En estos ejercicios tendrás que guardar las funciones en variables y luego usarlas.

### Función que sume dos números
Crea una función lambda que sume reciba dos parámetros y sume dos números. Guarda la función en una constante `sumarDosNumeros`.

`val sumarDosNumeros = ...`

??? success "Ver solución"
    ```kotlin
    val sumarDosNumeros = { a: Int, b: Int -> a + b }

    // Podemos poner entre ${} llamadas más complejas para no usar el operador '+'
    fun main() {
        println("La suma de 5 y 10 es: ${sumarDosNumeros(5, 10)}")
    }
    ```

Todos los siguientes ejercicios de esta parte debes intentar hacerlos de esta manera.

### Multiplicar
1. Haz lo mismo pero ahora con una función que sea `multiplicarPorDos`.
2. Ahora que se llame `multiplicarPor` y sean dos números que se multiplicarán uno por el otro.

### Comprobar si es par
Función que compruebe si un número es par.

### Longitud de un string
Siguiendo el mismo formato, guarda en una val una función que compruebe la longitud de un string.

### Devolver el mayor
Recibir como parámetro dos números y devolver el mayor. 

### Restar dos números
Crea una constante (`val`) y asígnale una función que se ocupe de retar dos números.

## Funciones de orden superior
En las listas de kotlin, existen funciones de orden superior que reciben, como parámetro, otras funciones: filter, map, reduce, forEach, count...

Realiza los siguientes ejercicios haciendo uso de estas funciones.

Dado lo siguiente:
```kotlin
val numeros = listOf(1, -2, 5, 16, 12, -5, -7, 9, 5, 21)
```

Realiza los siguientes ejercicios.

### Filtra números mayores que 5
Dada la lista anterior, filtra en otra lista de nombre `mayoresQue5` solo los números mayores que 5 (*filter*). Luego muéstralos por pantalla (*forEach*).

### Cuadrado de los números
Dada la misma lista, almacena en otra lista de nombre `duplicados` todos los números duplicados. Luego muéstralos por pantalla.

### Filtra los números positivos duplícalos
Ahora, hagamos lo anterior todo junto. Filtra los mayors que 5, duplicalos y finalmente muéstralos por pantalla. **Todo en la misma sentencia.** (`filter + map + forEach`).

### Mapeo de strings
Dada la siguiente lista:
```kotlin
val lenguajes = listOf("Kotlin", "Java", "JavaScript", "Scala", "Python", "Rust")
```

Haz lo siguiente:

1. Obtén una nueva lista con la longitud de cada palabra de la misma y muestra el resultado por pantalla.
2. Obtén una nueva lista con los elementos convertidos a mayúscula y muestra el resultado por pantalla.
3. Filtra las que empiezan por "J", conviértelas a mayúsculas y muéstralas por pantalla.

## Clases y objetos
### Clase alumno
1. Crea una clase `Alumno` con nombre (cadena), edad (entero) y nota (número decimal). Haz que si no se pone nota por defecto sea 0. 
2. Crea dos instancias de la clase Alumno, una usando parámetros ordenados y otra nombrados.

### Producto
Crea una clase `Producto` con sus *getters*, *setters*, *toString()*, *hashCode()* y *copy()* de la manera más simple posible con Kotlin (es una sola línea). Sus atributos:

- Nombre.
- Cantidad.
- Precio.

## Colecciones

### Listas inmutables y mutables
1. Crea una lista inmutable de tres strings ("uno", "dos" y "tres") utilizando `listOf`. Intenta añadir un elemento y borrar otro, verás que no puedes.
2. Crea ahora una lista mutable con `mutableListOf`. Intenta de nuevo añadir un elemento y eliminar otro.

### Listas mutables
Crea una `MutableList<String>` de productos:

- Añade 5 elementos
- Cambia el tercero
- Elimina el último
- Imprime los elementos con su índice

### Lista de objetos Alumno
Tienes la clase Alumno en los ejercicios de clases y objetos:

- Crea una lista de 5 alumnos.
- Filtra los que tengan nota > 7.
- Imprime solo sus nombres.
- Saca la media de las notas.
- Ordena la lista por nota descendente.

### Lista de objetos producto
Crea una `MutableList<Producto>` y:

1. Añade 4 productos    
2. Crea una función que calcule el **valor total del inventario** `cantidad * precio` de cada uno.
3. Crea otra función que busque un producto por nombre (si no existe, null).
4. Crea una función que aumente la cantidad de un producto.
5. Imprime un resumen formateado del inventario.

## Ejercicios complejos
### Clase alumno con validaciones

Crea una nueva clase `Alumno` con:

- Nombre
- Apellidos
- Edad (no puede ser < 0 ni > 120)
- Lista de notas (lista mutable de enteros)
- Método para añadir nota validando rango 0–10
- Método para calcular media
- Método que devuelva si está aprobado

### Pedidos de productos
Crea 3 clases:

#### Clase Producto
- Nombre
- Precio
- Categoría (enum: ELECTRONICA, ROPA, HOGAR)

Con validación en `init`.

#### Clase LineaPedido

- Producto
- Cantidad (mínimo 1)
- Método para obtener precio total (producto.precio * cantidad)

#### Clase Pedido
- Código
- Lista de líneas
- Método para añadir línea
- Método para obtener importe total
- Método para aplicar descuento en %
- Método para mostrar un resumen

### Ejercicio banco
Crea:

#### Clase CuentaBancaria
- Número de cuenta
- Titular
- Saldo
- Métodos: ingresar(), retirar() (con validación), transferir()

#### Clase Cliente
- Nombre
- Email
- Lista de cuentas

#### Clase Banco
- Nombre
- Lista de clientes
- Método para buscar cliente por email
- Método para crear cuenta nueva
- Método para transferencias entre cuentas