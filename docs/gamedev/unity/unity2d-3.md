Si modificamos el tamaño (escala) del cuadrado, podemos hacerlo parecer una plataforma.

![Conejo y tres plataformas](images/unity-conejo-3-plataformas-rectangulares.png)

!!! Note "Ejercicio"
    Crea tres plataformas rectangulares sobre las que, en el futuro, nuestro personaje pueda subirse:
    
    - Una de ellas hazla creando un cuadrado directamente desde el menú.
    - Las otras dos creando un GameObject vacío y luego añadiendo el componente con la imagen de un cuadrado (a ver si la encuentras!).


## Movimiento del personaje

!!! Note "Ejercicio"

    1. Crea un nuevo proyecto Universal2D y en él crea una cápsula (recuerda, está en *2D Objects - Sprites*). Luego crea un script asociado a la misma.
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