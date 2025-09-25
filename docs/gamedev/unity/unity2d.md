# Unity 2D
## Descarga de Unity
Para desarrollar para Unity, puedes descargarte primero UnityHub (es una aplicación donde puedes gestionar diversas versiones de Unity). Unity, por su parte, es el propio motor de videojuegos (y lo puedes descargar desde Unity Hub).

En pocas palabras, el primer paso es descargarte [UnityHub](https://unity.com/es/unity-hub) y después, desde dentro de Unity Hub podrás descargar la última versión estable de Unity (es posible que se te inicie la descarga automáticamente).

![Unity Hub](images/unity-hub.png)

En la imagen anterior podemos ver las pestañas de **proyectos** e **instalaciones** (estamos en la de instalaciones). Arriba podemos pulsar en "Instalar Editor" para instalar versiones de Unity. Es posible que al entrar ahí ya se te ponga una versión a descargar automáticamente (sino, lo puedes hacer con el botón correspondiente).

## Creación de proyecto en Unity
Para crear un proyecto 2D vamos a "Projects" - New Project (y elegimos Universal 2D):

![Nuevo proyecto](images/unity-new-project.png)

!!! Ejercicio
    1. Descarga UnityHub y la última versión estable de Unity.
    2. Elige una carpeta para tus proyectos (p. ej: juegos-unity). Después, elige esa carpeta y dentro de ella crea un proyecto **de tipo Universal 2D** que se llame PrimerJuego.

## Configuraciones del editor de Unity
### Configurar editor de texto para programar
Podemos elegir Visual Studio 2022 o Visual Studio Code.
![Editor de texto](images/unity-configurar-editor-texto.png)

### Cambiar color al estar en modo "ejecución"
Si ejecutamos un juego y mientras estamos jugándolo cambiamos parámetros del mismo, estos no se cambian. Para identificar cuando estamos en modo "ejecución" es mejor cambiar el color del IDE: 

*Edit → Preferences → Colors → Playmode tint*

![Color en modo juego](images/unity-color-modo-juego.png)

### Teclas (viejo, input system antiguo)
Para cambiar las teclas del juego puedes ir a: *Edit - Project - Input Manager*
![Cambiar teclas](images/unity-cambiar-teclas.png)

## Creación de objetos en Unity
Creamos un proyecto nuevo en Unity de tipo "Universal2D". Los objetos más básicos en Unity son de tipo "GameObject".

Vamos a crear nuestro primer objeto:
![Crear sprite 2D](images/unity-crear-sprite-cuadrado.png)

## Movimiento del personaje
### Conceptos básicos
Tipos de datos:

- **Vector2**: coordenadas x e y.
- **Vector3**: coordenadas x, y, z.

Existen dos métodos básicos:

- **Start()**: se ejecuta **solo una vez, al ejecutar el juego**.
- **Update()**: se ejecuta **una vez por frame**. Es decir, tipicamente unas 30 a 60 veces por segundo.

```csharp
public class PersonajeController : MonoBehaviour
{
    // Se llama justo antes de ejecutarse el primer frame
    void Start()
    {
     
    }

    // Update se llama una vez por frame
    void Update()
    {
     
    }
}
```

!!! Note "Ejercicio"

    1. En un proyecto Universal2D, crea una cápsula (recuerda, está en *2D Objects - Sprites*). Luego crea un script asociado al cuadrado.
    2. Muestra un mensaje "Hola mundo" cuando se ejecute el primer frame. Para esto puedes usar `Debug.Log("Mensaje")`. Ejecuta el juego para probar que aparece en la consola de Unity.
    3. Si consigues que funcione lo anterior, ahora intenta que se muestre un contador una vez por frame (y que ese contador vaya aumentando). El mensaje será "Frame número: X"

## Componente transform: moviendo el personaje
Al pulsar sobre la cápsula que hemos hecho, a la derecha vemos que tiene diversas propiedades: **transform, Sprite Renderer y Script**.

Cada una de ellas tiene un objetivo concreto. El script lo tiene porque le hemos asociado uno, el Sprite renderer es porque hay un dibujo (un sprite) asociado, en este caso de una cápsula pero podría ser cualquier fichero de imagen que queramos.

El transform se refiere a la posición del objeto en el juego. Tiene como propiedades: position (posición), rotation (rotación) y escala (tamaño).
![transform](images/unity-transform.png).

!!! Note "Ejercicio"
    1. Mueve el objeto modificando las propiedades del "position" de transform. Prueba tmabién a moverlo a mano usando la tecla "w" y las flechas.
    2. Rota el objeto unos 45 grados usando el "rotation" del transform. Prueba a rotarlo en todos los ejes (x, y, z) uno detrás de otro. 
    3. Luego, prueba también a rotar usando la tecla "r" y girando el objeto. Verás que los números del transform se van cambiando.
    4. Prueba a cambiar la escala del objeto.

### Transform: método Rotate()
Con todo lo anterior vemos como cambiar el objeto de forma permanente en el juego (ya sea la posición, escala o rotación). Muchas veces, nos interesa hacerlo dinamicamente desde código (por ejemplo, rotar el personaje cuando lo vas moviendo). La clase `MonoBehaviour` de la que heredamos en el script posee la propiedad `transform`, así que podemos acceder a ella en código con:

```csharp
transform.Rotate(0, 0, 0); // coordenadas x, y, z
```

!!! Ejercicio
    1. Haz que la cápsula gire 45 grados nada más empezar el juego (hazlo en el script, no en Unity).
    2. Haz que la cápsula gire 45 grados en cada frame (en script).
    3. Haz que la cápsula gire sin parar muy lentamente (aproximadamente que haga un giro completo cada 5 segundos). Ojo, si usas cifras decimales necesitas añadir una "f" al final (por ejemplo: 5.5f).
    4. Finalmente, deja todo como al principio (puedes comentar las líneas de código del transform).


### Transform: position
Podemos cambiar la posición también y hacer que el objeto se mueva lentamente. `transform.position` es de tipo Vector3.

Por ejemplo, si hacemos lo siguiente:

```csharp
void Start()
{
    transform.position = new Vector3(2, 4, 0);
}
```

Al ejecutar, el personaje (en este caso la cápsula) se moverá 2 en el eje X y 4 puntos en el eje Y.

![Posicion capsula](images/unity-transform-position.png)

!!! Note "Ejercicio: sumar vectores"
    1. Si mueves el código de cambio de posición del método "Start()" a Update(), ¿qué crees que ocurrirá? Pruébalo.
    2. Recuerda, position no es un número, es un objeto de tipo "Vector3" que recibe 3 coordenadas. Aún así, **podemos sumar dos objetos de tipo Vector3 con el operador +** (igual que en una suma de números). Eso sí, no podemos sumar un Vector3 + número, tiene que ser Vector3 + Vector3. Intenta ahora que el objeto se mueva lentamente hacia arriba (tendrás que ir actualizando el position con una posición un poco más alta en y cada vez).

### Transform: método Translate()
Para cambiar la posición de un objeto, hay una forma más cómoda que cambiar el position y es con el método **Translate()**. El método **Translate** nos evita tener que sumar a mano. Vamos a ver como funciona:

```csharp
    void Update()
    {
        // transform.position = transform.position + new Vector3(0, 0.01f, 0);
        transform.Translate(0, .01f, 0);
    }
```

!!! Note "Ejercicio"
    1. Prueba el código anterior pero ahora, añade una línea más usando el transform.Rotation para que gire un poco.

    Puede que no lo esperes, pero haciendo esto el objeto hará círculos (ya que el movimiento en "y" es sobre sí mismo, no sobre el mundo). Si no lo entiendes prueba a pulsar sobre la cápsula y pulsar "w", verás las flechas y posiblemente entenderás este comportamiento.


## Sprites
Un Sprite en Unity es un objeto C# que representa una imagen. En este caso, nuestra cápsula es un Sprite que es un dibujo de una cápsula, podemos ver que tenemos **Sprite Renderer** además de transform:

![Sprite renderer](images/unity-sprite-renderer.png)


Bien, pues podemos hacer que en lugar de una cápsula lo que movemos sea un coche, vamos a hacerlo. 

!!! Note "Ejercicio: descargar y colocar sprite de un coche"
    1. Cambia el nombre de tu cápsula a "Coche".
    2. Busca en Google "car sprites" y descarga la imagen de un coche cualquiera que se vea desde arriba, por ejemplo [este](https://nohat.cc/f/related-posts-scratch-race-car-sprite/m2i8K9K9A0d3G6b1-201907241634.html). 
    3. Una vez lo descargues mételo en la carpeta "assets" de tu proyecto Unity.
    4. Arrastramos el sprite desde los recursos (assets) de nuestro proyecto, a la propiedad "Sprite" del Coche (ver imagen).
    5. Finalmente, ajustamos el tamaño (escala) y rotación del coche para que quede lo mejor que podamos (y ejecutamos el juego para probar).
    
    ![Cambiar imagen del coche](images/unity-cambiar-sprite.png)