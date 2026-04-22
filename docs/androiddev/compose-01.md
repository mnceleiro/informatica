# Desarrollo de interfaces en Android con Compose
Hasta ahora hemos trabajado con Kotlin, pero todavía no hemos creado interfaces gráficas para Android.

En Android, la interfaz es todo lo que ve y toca el usuario:

- Textos
- Botones
- Imágenes
- Cajas de texto
- Listas
- Pantallas completas

Para crear esas interfaces vamos a usar **Jetpack Compose**.

## ¿Qué es Jetpack Compose?
Jetpack Compose es la forma moderna de crear interfaces en Android usando Kotlin.

Antes, en Android era muy habitual crear las pantallas con ficheros XML. Es decir, por un lado teníamos el código Kotlin y por otro lado teníamos ficheros XML donde se definía la interfaz.

Con Compose la idea cambia bastante:

- La interfaz se escribe directamente con Kotlin.
- Las pantallas se construyen usando funciones.
- Cada parte de la interfaz se puede dividir en funciones pequeñas.

Por ejemplo, en lugar de crear un botón en XML, en Compose escribiremos algo parecido a esto:

```kotlin
Button(
    onClick = {}
) {
    Text("Púlsame")
}
```

No te preocupes si todavía no entiendes todos los detalles. La idea importante por ahora es esta: **en Compose vamos a construir interfaces escribiendo código Kotlin**.

## Funciones que pintan cosas
En Kotlin ya hemos visto funciones. Por ejemplo:

```kotlin
fun saludar() {
    println("Hola")
}
```

Esta función ejecuta código y escribe un mensaje por consola.

En Compose también vamos a crear funciones, pero algunas de esas funciones no van a escribir por consola, sino que van a **dibujar elementos en la pantalla**.

Por ejemplo:

```kotlin
@Composable
fun PantallaPrincipal() {
    Text("Hola Android")
}
```

Esta función tiene algo nuevo: `@Composable`.

La anotación `@Composable` le dice a Android que esa función forma parte de la interfaz. Es decir, no es una función normal cualquiera: es una función que puede pintar componentes en pantalla.

De momento quédate con esta idea:

- Una función normal ejecuta instrucciones.
- Una función `@Composable` construye una parte de la interfaz.

!!! Info "Recuerda"
    Si quieres que tu función pinte algo en pantalla, tiene que tener la anotación @composable.

## Primer contacto con un proyecto Compose
Cuando creamos un proyecto nuevo de Android con Compose, Android Studio nos genera bastante código automáticamente. Para crear un proyecto en Compose puedes hacer lo siguiente:

1. Abrir Android Studio y seleccionar "Nuevo" -> "Nuevo proyecto".
2. Luego, seleccionar "Activity vacía" (o "Empty Activity").
3. Después, poner un nombre al proyecto y pulsa "finalizar".

Con esto, tendrás un proyecto creado que podrás ver en el emulador.

Al principio esto puede abrumar un poco, porque aparecen muchos ficheros que todavía no conocemos. No pasa nada. En esta primera parte no vamos a entenderlo todo de golpe.

Ahora, quiero que te fijes en el fichero `MainActivity.kt`, que suele ser el **punto de entrada principal de la aplicación**.

Dentro de ese fichero verás algo parecido a esto:

```kotlin
setContent {
    NombreDelProyectoTheme {
        Greeting("Android")
    }
}
```

La función `setContent` indica qué interfaz se va a mostrar en pantalla.

Dicho de forma simple:

- `MainActivity` arranca la aplicación.
- `setContent` coloca la interfaz en pantalla.
- Las funciones `@Composable` definen las piezas de esa interfaz.

!!! Note "Ejercicio"
    1. Crea un proyecto nuevo en Android Studio usando una plantilla básica con Jetpack Compose.
    2. Ejecuta el proyecto sin modificar nada y comprueba que la aplicación se abre correctamente.
    3. Abre el fichero `MainActivity.kt`.
    4. Busca la función `setContent`.
    5. Busca alguna función que tenga la anotación `@Composable`.
    6. Cambia el texto que aparece por defecto en pantalla por otro texto distinto, por ejemplo: "Hola Compose".
    7. Ejecuta de nuevo la aplicación y comprueba que el texto ha cambiado.

No te preocupes si todavía no entiendes todo el código que aparece en el proyecto. En este primer ejercicio lo importante es localizar las piezas principales y comprobar que somos capaces de modificar una parte pequeña de la interfaz.

## Creando nuestra primera función composable
En Compose, lo normal es dividir la interfaz en funciones pequeñas. Cada función se encarga de pintar una parte de la pantalla.

Para empezar a ordenar un poco el proyecto, no vamos a meter todas las funciones dentro de `MainActivity.kt`. Vamos a crear un paquete llamado `components` y, dentro, un fichero Kotlin llamado `MiPrimeraPantalla.kt`.

La estructura quedaría parecida a esta:

```text
app
└── java
    └── tu.paquete
        ├── MainActivity.kt
        └── components
            └── MiPrimeraPantalla.kt
```

Dentro de `MiPrimeraPantalla.kt` vamos a crear una función muy sencilla:

```kotlin
@Composable
fun MiPrimeraPantalla() {
    Text("Mi primera pantalla con Compose")
}
```

Esta función no devuelve un `String`, ni un número, ni un objeto. Su trabajo es **pintar algo en la pantalla**.

Para que Android muestre esta función, tenemos que llamarla dentro de `setContent`:

```kotlin
setContent {
    NombreDelProyectoTheme {
        MiPrimeraPantalla()
    }
}
```

Fíjate en la idea:

- `setContent` indica qué se dibuja en la pantalla.
- `MiPrimeraPantalla()` es la función que hemos creado nosotros.
- `Text(...)` es el componente que muestra texto.

!!! Note "Ejercicio"
    1. Crea un paquete llamado `components`.
    2. Dentro de ese paquete, crea un fichero Kotlin llamado `MiPrimeraPantalla.kt`.
    3. En ese fichero, crea una función llamada `MiPrimeraPantalla`.
    4. Dentro de esa función, muestra un texto usando `Text`.
    5. Vuelve a `MainActivity.kt` y llama a `MiPrimeraPantalla()` dentro de `setContent`.
    6. Ejecuta la aplicación y comprueba que aparece tu texto.
    7. Cambia el texto por otro distinto y vuelve a ejecutar la aplicación.

## Importaciones
Al escribir `@Composable` o `Text`, es posible que Android Studio los marque en rojo al principio. Esto suele pasar porque faltan los `import`.

En Kotlin ya hemos visto que, para usar ciertas clases o funciones, a veces hay que importarlas. En Compose pasa lo mismo.

Por ejemplo, para poder usar `Text`, normalmente necesitaremos este import:

```kotlin
import androidx.compose.material3.Text
```

Y para poder usar `@Composable`, necesitaremos este otro:

```kotlin
import androidx.compose.runtime.Composable
```

No hace falta aprenderse todos los imports de memoria. Android Studio suele ayudarnos a importarlos automáticamente cuando pulsamos `Alt + Enter` sobre el elemento que aparece en rojo.

!!! Note "Ejercicio"
    1. Borra el import de `Text` si lo tienes en tu fichero.
    2. Observa qué error aparece en Android Studio.
    3. Coloca el cursor encima de `Text`.
    4. Pulsa `Alt + Enter` y deja que Android Studio añada el import automáticamente.
    5. Repite el mismo proceso si te ocurre con `@Composable`.

## Previsualizar componentes
Una de las cosas cómodas de Compose es que podemos previsualizar algunos componentes sin tener que ejecutar toda la aplicación en el emulador.

Para eso usamos la anotación `@Preview`.

Por ejemplo:

```kotlin
@Preview
@Composable
fun PreviewMiPrimeraPantalla() {
    MiPrimeraPantalla()
}
```

Esta función no la llamamos desde `setContent`. Su objetivo es que Android Studio pueda mostrar una vista previa de nuestra pantalla mientras estamos programando.

Hay una diferencia importante:

- `MiPrimeraPantalla` es el componente real que queremos usar.
- `PreviewMiPrimeraPantalla` sirve solo para verlo en Android Studio.

Normalmente, las funciones de preview llaman por dentro a otras funciones composable. Así evitamos duplicar el código de la interfaz.

!!! Note "Ejercicio"
    1. En el fichero `MiPrimeraPantalla.kt`, debajo de la función `MiPrimeraPantalla`, crea una función `PreviewMiPrimeraPantalla`.
    2. Añade las anotaciones `@Preview` y `@Composable`.
    3. Dentro, llama a `MiPrimeraPantalla()`.
    4. Abre la vista `Split` o `Design` de Android Studio.
    5. Comprueba si aparece la previsualización.
    6. Cambia el texto de `MiPrimeraPantalla` y observa si se actualiza también en la preview.

## Opciones de Preview
La anotación `@Preview` puede recibir algunas opciones para modificar cómo se muestra la previsualización.

Una opción muy útil al principio es `showSystemUi`.

```kotlin
@Preview(showSystemUi = true)
@Composable
fun PreviewMiPrimeraPantalla() {
    MiPrimeraPantalla()
}
```

Con `showSystemUi = true`, Android Studio muestra la preview dentro de una pantalla de móvil más realista, incluyendo elementos del sistema.

Esto no cambia la aplicación real. Solo cambia cómo se ve la previsualización dentro de Android Studio.

!!! Note "Ejercicio"
    1. Cambia tu `@Preview` por `@Preview(showSystemUi = true)`.
    2. Observa qué diferencia aparece en la previsualización.
    3. Vuelve a dejarlo como `@Preview` y compara el resultado.
    4. Finalmente, déjalo como `@Preview(showSystemUi = true)`.

## El componente Text
El primer componente que estamos usando es `Text`.

`Text` sirve para mostrar texto en pantalla. Es algo parecido a hacer un `println`, pero en lugar de escribir en la consola, escribe en la interfaz gráfica.

El ejemplo más sencillo es este:

```kotlin
Text("Hola Compose")
```

También podemos escribirlo indicando el nombre del parámetro:

```kotlin
Text(
    text = "Hola Compose"
)
```

Las dos formas hacen lo mismo, pero la segunda es más clara cuando el componente empieza a tener más opciones.

En Kotlin ya hemos visto que las funciones pueden recibir parámetros. En Compose ocurre igual: los componentes son funciones y reciben parámetros para configurar cómo se ven o cómo se comportan.

De momento vamos a usar `Text` solo con su parámetro más básico: `text`.

!!! Note "Ejercicio"
    1. En `MiPrimeraPantalla`, cambia el texto que estás mostrando por tu nombre.
    2. Escríbelo primero de esta forma: `Text("Tu nombre")`.
    3. Después, cámbialo para usar el parámetro con nombre: `Text(text = "Tu nombre")`.
    4. Comprueba en la preview que el resultado es el mismo.

## Mostrando varios componentes
Vamos a probar a escribir dos textos dentro de la misma función:

```kotlin
@Composable
fun MiPrimeraPantalla() {
    Text(text = "Hola")
    Text(text = "Estoy aprendiendo Compose")
}
```

Esto parece razonable, pero nos falta una idea importante: **tenemos que indicar cómo se colocan esos elementos en la pantalla**.

En Compose existen componentes que sirven para organizar otros componentes. Uno de los más sencillos es `Column`.

`Column` coloca los elementos uno debajo de otro, en vertical.

```kotlin
@Composable
fun MiPrimeraPantalla() {
    Column {
        Text(text = "Hola")
        Text(text = "Estoy aprendiendo Compose")
    }
}
```

Aquí `Column` no muestra texto por sí misma. Su trabajo es ordenar los componentes que tiene dentro.

La idea es:

- `Text` muestra texto.
- `Column` coloca elementos en vertical.
- Dentro de `Column` podemos meter varios componentes.

!!! Note "Ejercicio"
    1. Modifica `MiPrimeraPantalla` para que use una `Column`.
    2. Dentro de la `Column`, añade dos componentes `Text`.
    3. El primer texto debe mostrar tu nombre.
    4. El segundo texto debe mostrar el nombre del ciclo o asignatura.
    5. Comprueba el resultado en la preview.

## Colocando elementos en horizontal
Igual que `Column` coloca elementos en vertical, existe otro componente llamado `Row`.

`Row` coloca los elementos uno al lado de otro, en horizontal.

```kotlin
@Composable
fun MiPrimeraPantalla() {
    Row {
        Text(text = "Ada")
        Text(text = "Lovelace")
    }
}
```

La idea es muy parecida:

- `Column` coloca elementos de arriba a abajo.
- `Row` coloca elementos de izquierda a derecha.

Por ahora no vamos a preocuparnos por separaciones, márgenes ni tamaños. Primero nos interesa entender cómo se ordenan los componentes.

!!! Note "Ejercicio"
    1. Cambia la `Column` anterior por una `Row`.
    2. Dentro de la `Row`, añade dos textos.
    3. El primer texto debe mostrar tu nombre.
    4. El segundo texto debe mostrar tus apellidos.
    5. Comprueba el resultado en la preview.
    6. Vuelve a cambiar `Row` por `Column` y observa la diferencia.

## Combinando Column y Row
Las interfaces se construyen combinando componentes pequeños.

Por ejemplo, podemos tener una `Column` que coloca varias filas en vertical, y dentro de una de esas filas usar una `Row`.

```kotlin
@Composable
fun MiPrimeraPantalla() {
    Column {
        Text(text = "Ficha de la alumna")

        Row {
            Text(text = "Nombre: ")
            Text(text = "Grace Hopper")
        }

        Row {
            Text(text = "Ciclo: ")
            Text(text = "DAM")
        }
    }
}
```

En este ejemplo:

- La `Column` organiza toda la pantalla en vertical.
- Cada `Row` organiza una pequeña línea en horizontal.
- Los `Text` muestran la información.

Esto es muy habitual en Compose: usar componentes que contienen otros componentes.

!!! Note "Ejercicio"
    1. Modifica `MiPrimeraPantalla` para crear una pequeña ficha personal.
    2. Usa una `Column` principal.
    3. Añade un primer `Text` con el título "Ficha personal".
    4. Añade una `Row` para mostrar tu nombre.
    5. Añade otra `Row` para mostrar tu ciclo o curso.
    6. Añade otra `Row` para mostrar tu asignatura favorita.
    7. Comprueba el resultado en la preview.

## Botones
Hasta ahora solo hemos mostrado textos, pero una interfaz normalmente también tiene elementos con los que el usuario puede interactuar.

Uno de los componentes interactivos más habituales es el botón.

Para no mezclar estos ejemplos con `MiPrimeraPantalla`, vamos a crear un fichero nuevo dentro del paquete `components` llamado `PantallasBotones.kt`.

En ese fichero iremos creando ejemplos pequeños:

- `PantallaBotones1`
- `PantallaBotones2`
- `PantallaBotones3`

Empezamos con el primer ejemplo. En Compose podemos crear un botón con `Button`:

```kotlin
@Composable
fun PantallaBotones1() {
    Button(
        onClick = {}
    ) {
        Text(text = "Guardar")
    }
}
```

Fíjate en que el botón tiene dos partes importantes:

- `onClick = {}` indica qué debe ocurrir cuando se pulsa el botón.
- Dentro del bloque del botón hemos puesto un `Text`, que es el texto que se ve dentro del botón.

De momento el botón no hará nada al pulsarlo. Hemos dejado `onClick` vacío para centrarnos primero en conseguir que el botón aparezca en pantalla.

Para poder verlo en Android Studio, creamos también su preview:

```kotlin
@Preview(showSystemUi = true)
@Composable
fun PreviewPantallaBotones1() {
    PantallaBotones1()
}
```

!!! Note "Ejercicio"
    1. Crea un fichero llamado `PantallasBotones.kt` dentro del paquete `components`.
    2. Crea una función llamada `PantallaBotones1`.
    3. Dentro, añade un `Button`.
    4. El botón debe mostrar el texto "Aceptar".
    5. Crea una preview llamada `PreviewPantallaBotones1`.
    6. Comprueba el resultado en la preview.
    7. Cambia el texto del botón por "Guardar cambios".
    8. Comprueba de nuevo el resultado en la preview.

## Botones dentro de una pantalla
Normalmente no tendremos un botón aislado, sino una pantalla con textos, filas, columnas y botones.

Podemos combinar lo que ya sabemos:

```kotlin
@Composable
fun PantallaBotones2() {
    Column {
        Text(text = "Ficha de la alumna")

        Row {
            Text(text = "Nombre: ")
            Text(text = "Grace Hopper")
        }

        Row {
            Text(text = "Ciclo: ")
            Text(text = "DAM")
        }

        Button(
            onClick = {}
        ) {
            Text(text = "Guardar")
        }
    }
}
```

En este ejemplo, la `Column` coloca todos los elementos en vertical:

- Primero aparece el título.
- Después aparecen las filas con información.
- Finalmente aparece el botón.

Podemos crear otra preview para este segundo ejemplo:

```kotlin
@Preview(showSystemUi = true)
@Composable
fun PreviewPantallaBotones2() {
    PantallaBotones2()
}
```

!!! Note "Ejercicio"
    1. En el mismo fichero `PantallasBotones.kt`, crea una función llamada `PantallaBotones2`.
    2. Dentro, crea una `Column`.
    3. Añade un título con `Text`.
    4. Añade dos `Row` con información.
    5. Añade un `Button` al final de la `Column`.
    6. Dentro del botón, añade un `Text` con el texto "Guardar".
    7. Crea una preview llamada `PreviewPantallaBotones2`.
    8. Comprueba el resultado en la preview.
    9. Cambia el texto del botón por "Enviar ficha".

## El parámetro onClick
El parámetro `onClick` es una función que se ejecuta cuando se pulsa el botón.

Por ahora vamos a hacer algo muy sencillo: escribir un mensaje en la consola.

```kotlin
@Composable
fun PantallaBotones3() {
    Button(
        onClick = {
            println("Se ha pulsado el botón")
        }
    ) {
        Text(text = "Guardar")
    }
}
```

Y, como en los ejemplos anteriores, podemos crear su preview:

```kotlin
@Preview(showSystemUi = true)
@Composable
fun PreviewPantallaBotones3() {
    PantallaBotones3()
}
```

Esto no cambia nada en la pantalla, pero nos sirve para entender que dentro de `onClick` podemos escribir código Kotlin.

La idea es:

- El botón se muestra en pantalla.
- El usuario pulsa el botón.
- Se ejecuta el código que hay dentro de `onClick`.

Más adelante haremos que al pulsar un botón cambien cosas de la interfaz, pero para eso primero necesitaremos entender los estados.

!!! Note "Ejercicio"
    1. En el mismo fichero `PantallasBotones.kt`, crea una función llamada `PantallaBotones3`.
    2. Añade un botón con el texto "Guardar".
    3. Dentro del `onClick`, añade un `println`.
    4. Escribe un mensaje como "Botón pulsado".
    5. Crea una preview llamada `PreviewPantallaBotones3`.
    6. Lee el código y asegúrate de entender cuándo se ejecutaría ese mensaje.
    7. Cambia el mensaje por otro distinto.
