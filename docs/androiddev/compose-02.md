# Jetpack Compose: TextFields y estados

## Estados y recomposiciones en Android
Vamos a ver como funcionan los estados y recomposiciones en Compose. Esto lo mostraremos con el componente `TextField`.

Para crear una caja de texto en Compose (en HTML se llama <input\>, en android XML se llama EditText, TextBox en Windows Forms, etc.) usamos el componente `TextField` o `OutlinedTextField`.

### TextField: primer ejemplo
Veamos primero el ejemplo más básico posible:

=== "Clase MainActivity"

    En el **MainActivity** dejamos solo lo siguiente:

    ```kotlin
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            TestCompose01Theme { // (1)!
                Column {    
                    // Iremos cambiando 1, 2, 3... según vamos haciendo ejemplos
                    TextField1()
                }
            }
        }
    }
    ```

    1. Esto no se llamará "TestCompose01Theme", sino que dependerá del nombre que le hayas puesto a tu proyecto.

=== "Fichero MiTextField"

    Creamos el componente en un nuevo fichero kotlin (MiTextField.kt):

    ```kotlin
    @Preview(showSystemUi = true)  
    @Composable  
    fun TextField1(modifier: Modifier = Modifier) {  
        TextField(  
            value = "Hola",  
            onValueChange = {}  
        )  
    }
    ```

=== "Resultado esperado"
    ![TextField](images/textfield1.png)


!!! Note "Ejercicio"
    Escribe el código anterior y intenta lograr el "resultado esperado". Ten en cuenta que no funcionará la escritura todavía, solo debes hacer que se vea como en la imagen.

### TextField: segundo ejemplo
En el primer ejemplo asignábamos el valor `Hola` al `value` del `TextField`. Esto funciona y nos lo muestra, pero **no podemos modificarlo**. No vamos a poder durante un rato, hasta que entendamos todo el funcionamiento de como funciona el estado y las recomposiciones en Compose de forma adecuada.

Vamos a hacer una "leve mejora", intentaremos poder modificar el valor haciendo uso del `onValueChange`:

=== "Clase MainActivity"

    En el **MainActivity** dejamos solo lo siguiente:

    ```kotlin
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            TestCompose01Theme { // (1)!
                Column {    
                    // Iremos cambiando 1, 2, 3... según vamos haciendo ejemplos
                    TextField2()
                }
            }
        }
    }
    ```

    1. Esto no se llamará "TestCompose01Theme", sino que dependerá del nombre que le hayas puesto a tu proyecto.

=== "Fichero MiTextField"

    ```kotlin
    @Preview(showSystemUi = true)  
    @Composable  
    fun TextField2(modifier: Modifier = Modifier) {
        // Declaramos primero el texto de la caja
        var texto: String = ""  

        // Creamos una función que se debe ejecutar cuando el valor cambie
        val funcionAEjecutarseAlCambiarElValor = { nuevoTexto: String ->  
            texto = nuevoTexto  
        }  
    
        // Montamos el TextField
        TextField(  
            value = "",  
            onValueChange = funcionAEjecutarseAlCambiarElValor  
        )  
    }
    ```

En este caso hemos quitado el texto (no tiene sentido que aparezca nada por defecto).

- Seguimos sin poder escribir sobre la caja de texto.
- Hemos declarado una función ahí, cuándo podríamos hacerlo directamente. En lugar de declarar la función y luego usarla, la aplicaremos directamente en el onValueChange en el siguiente ejemplo.

#### TextField (segundo ejemplo): problemas
Seguimos sin poder editar, la pregunta es, ¿por qué? 

Para entenderlo necesitamos comprender como funcionan la rescomposiciones en Android. Compose pinta sobre la pantalla los componentes y, cuando hay algún cambio en estos (p. ej: escribir una letra en el TextField) Compose dispara una **recomposición**. Esto es, vuelve a ejecutarse la función `TextField2` desde cero.

No está funcionando porque nos quedan por solucionar dos problemas:

- Problema I: como hemos descrito arriba, cada vez que algo cambia (en este caso el TextField) se dispara una **recomposición**. Esto significa que el componente se volverá a cargar (la función se vuelve a llamar). Al llamar a la función, **la variable "text" vuelve a inicializarse a cadena vacía ("")**. Por esta razón nunca funcionará, ya que su valor siempre será un string vacío.
- Problema II: no importa el problema 1 todavía porque, aunque es real, la recomposición no se está disparando **NUNCA**. Vamos a ver primero por qué no se está disparando la recomposición y después resolveremos el problema I.

### TextField (tercera mejora)
Vamos a seguir haciendo mejoras continuas. Primero, vamos a refactorizar el código para poner todo en el `onValueChange` y después **resolveremos el problema II (la UI no se recompone)**. Modifica `TextField2` para dejarlo así:

```kotlin
@Composable
fun TextField3(modifier: Modifier = Modifier) {
    println("NOTA: Ha habido una recomposición.")

    var texto: String = ""

    TextField(
        value = texto,
        onValueChange = {
            texto = it

            println("NOTA: El valor del texto ha cambiado a ${it}")
        }
    )
}
```

Hemos hecho lo siguiente:

- Eliminamos la declaración de la función y la integramos en el `onValueChange` directamente.
- Asignamos dos mensajes de `Debug` para ver si aparece en el `LogCat`. Para filtrar, busca por "NOTA".


!!! Note "Ejercicio"
    Ejecuta el tercer ejemplo y mira los mensajes que salen en el LOGCAT. Verás que solo aparece uno de recomposición (el de la creación del TextField).

Seguimos sin poder editar, esto es un sinvivir, ¿¡Qué leches está pasando!?

No os desanimeis, estamos ya cerca de resolverlo :-)

### TextField (cuarta mejora) - Recomposición
La razón de que la UI no se esté recomponiendo (el mensaje no sale más que una vez) es porque Android, para la recomposición, **solo comprueba si han cambiado variables de un determinado tipo (variables observables)**. En este caso nuestras variables no son *observables*.

Esto es, no podemos poner el texto como un `String`, sino que tenemos que envolverlo en otra clase de tipo **MutableState<T\>**. Esto podemos hacerlo con el método `mutableStateOf(Valor)`.

Vamos a hacerlo y luego le damos otra vuelta, ahí va el código:

```kotlin
@Composable
fun TextField4(modifier: Modifier = Modifier) {
    val texto = mutableStateOf("")  // (1)!

    val funcionAEjecutarseAlCambiarElValor = { nuevoTexto: String ->
        texto.value = nuevoTexto    // (2)!
    }

    TextField(
        value = texto.value,
        onValueChange = {
            texto.value = it        // (3)!

            println("NOTA: El valor del texto ha cambiado a ${it}")
        }
    )
}
```

1. Envolvemos el texto (de tipo string) en un objeto *MutableState<String\>*.
2. Ahora al acceder a la variable estamos accediendo a un *MutableState*. Para acceder al valor interno que tiene guardado lo hacemos con *.value*.
3. Lo mismo que en el anterior, tenemos que usar *texto.value*.

El código anterior te dará un *warning* en el *mutableStateOf*. Ignóralo de momento, luego lo vamos a arreglar. También, no olvides de usar *.value* (ya que ahora texto no es de tipo *String*, sino de *MutableState<String\>*)

!!! Note "Ejercicio"
    Intenta entender todo lo anterior y ejecuta el código. Con este nuevo código, responde a las siguientes preguntas:

    - ¿Funciona?
    - ¿Cuántos mensajes ves en el LogCat?
    - ¿Están disparándose las recomposiciones? Antes no lo hacían.

Bien, hemos introducido una mejora, si has ejecutado la aplicación deberías ver muchos mensajes en el LogCat cada vez que tecleas una letra. Aún así, la caja de texto sigue sin permitirnos escribir (lo que escribimos todavía no sale en la pantalla). 

### TextField (quinta mejora) - A escribir!
La razón de que, aunque la GUI se recomponga, no aparezca nada en pantalla, es **porque cada vez que hay una recomposición la función se vuelve a ejecutar y esta se está inicializando a cadena vacía todo el tiempo.**

Bien, solo tenemos que hacer que se guarde el estado de la variable `texto` entre recomposiciones. Si se inicializa a "", queremos que al recomponerse el componente su valor se mantenga fijo. Esto se hace con la función `remember`.

```kotlin
@Composable
fun TextField5(modifier: Modifier = Modifier) {
    var texto by remember { mutableStateOf("") }

    TextField(
        value = texto,
        onValueChange = {
            texto = it
        }
    )
}
```

!!! Tip "Función remember y rememberSaveable"
    - Remember es una función. Las funciones en Kotlin, cuando se recibe una *lambda* como último parámetro, nos permite sacar esta *lambda* fuera de los paréntesis (por eso no está envuelto lo de la derecha de *remember* entre paréntesis).
    - Además de *remember*, existe *rememberSaveable*. *Remember* nos permite cachear (guardar) el valor que tiene una variable entre recomposiciones, pero no lo hace si se destruye la activity (p. ej: si giras el móvil). *rememberSaveable* arreglaría esto.
    - La palabra clave *by* es un delegado (*delegate*). Esto nos permitirá eliminar el *.value* de nuestras variables (y hacerlo más amigable).

!!! Note "Ejercicio"
    - **Implementa el código anterior (ahora todo debería funcionar).** Además hemos podido eliminar los *.value* y el código queda más limpio. Hemos eliminado también los comentarios.
    - Prueba a ejecutar el código sin el *by* (cambiándolo por "="). Si lo haces, tendrás que poner .value a todo. Solo haz esto de prueba.

### TextField (última mejora)

Ahora vamos a centrarnos ya no en la recomposición, sino en el TextField en sí mismo. Vamos a disfrutar un poco probando cositas:

```kotlin
@Preview(showSystemUi = true)
@Composable
fun TextField6(modifier: Modifier = Modifier) {
    var texto by remember { mutableStateOf("") }

    TextField(
        value = texto,
        label = { Text("Email") },
        placeholder = { Text("Escribe tu email") },
        supportingText = { Text("Campo obligatorio", color = Color.Red) },
        onValueChange = {
            texto = it

            println("NOTA: El valor del texto ha cambiado a ${it}")
        },
        singleLine = true,

        // Tipo de teclado
        keyboardOptions = KeyboardOptions(
            keyboardType = KeyboardType.Email
        ),

        // Contraseña
        visualTransformation = PasswordVisualTransformation(),

        // Para meter un icono al principio del TextField...
        leadingIcon = {
            Icon(Icons.Default.Email, contentDescription = null)
        }
    )
}
```

!!! Note "Ejercicio"
    1. Prueba el TextField6 poco a poco. Ve añadiendo atributos uno a uno y consúltalos en la definición de la función `TextField` de Android (haciendo control + click).
    2. Prueba a cambiar el componente *TextField* por *OutlinedTextField*. Es otra apariencia del TextField que nos viene dada en Material 3.

Con esto has comprendido como funciona la recomposición en Compose y a usar lo más interesante del componente *TextField*.