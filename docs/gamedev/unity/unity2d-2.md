# Movimiento del personaje: solucionando problemas
Continuamos con el juego del conejo!

Ya estamos algo más cerca de hacer el próximo League of Legends :D, pero tenemos todavía algunos problemas con el movimiento:

1. Si te fijas bien, al mover el personaje en diagonal este va más rápido que si lo mueves solo en horizontal o solo en vertical.
2. Además, si el juego se ejecuta en un ordenador lento (que solo puede ejecutar, por ejemplo, 5 imágenes por segundo) respecto a uno muy rápido (que puede ejecutar 300 por segundo), el primero se moverá más lento que el segundo, y no queremos eso.
   1. 5 frames por segundo: 0.1 * 5 = 0.5 unidades de movimiento cada segundo.
   2. 300 frames por segundo: 0.1 * 300 = 30 unidades de movimiento cada segundo.

Vamos, de momento, a centrarnos en arreglar **el segundo problema (frames)**.

## Solucionando el problema de los frames: Time.deltaTime()
Podemos arreglar estos problemas multiplicando el movimiento por la variable `Time.deltaTime`. Esta variable representa **el tiempo entre cada frame**

Siguiendo el ejemplo anterior: 
- Para 5 FPS el deltaTime será 1/5 = 0.2. El deltaTime será 0.2 en este caso porque cada frame se ejecuta cada 0.2 segundos. Si multiplicamos 0.2 por el número de frames (5) el resultado nos da 1.
- Para 300 FPS el deltaTime será 1/300 = 0.0034. Cada frame se ejecuta cada 0.0034 segundos. Si multiplicamos 0.0034 * 300 (el número de frames) nos da 1.

En resumen:
- Si multiplicamos la velocidad 0.1f * 0.2 nos da **0.02**. Eso, multiplicado por el número de frames (5) nos da como resultado 1.
- Si multiplicamos la velocidad 0.1f * 0.0034 nos da como resultado 0.00034. Eso, multiplicado por el número de frames (300) nos da como resultado 1.

Multiplicando la velocidad a la que nos movemos por `Time.deltaTime` nos moveremos lo mismo sin importar lo rápido o lento que sea el equipo en el que estamos jugando.

Además de esto, en nuestro código la velocidad es de 0.1f pero, ¿y si queremos cambiar la velocidad? Tal y como está escrito hay que cambiarla en 4 sitios, lo cuál deja un código muy feo y poco reutilizable.

Podríamos mejorarlo un poco:
```csharp
public class PlayerController : MonoBehaviour
{
    float velocidad = 0.02f;

    // Código...

    void Update()
    {
        int movimientoX = 0;
        int movimientoY = 0;

        // Más código...

        transform.position = new Vector3(
            transform.position.x * movimientoX * velocidad,
            transform.position.x * movimientoY * velocidad,
            transform.position.z
        );
    }
}
```
=== "Ejercicio"

    !!! Note "Ejercicio: independencia de los frames y refactorización de código"
        1. Modifica el código para que el movimiento sea independiente de los FPS (frames por segundo). El personaje debe moverse a la misma velocidad sin importar los FPS del equipo.
        2. El código actualmente es muy repetitivo. Mejóralo creando un atributo "velocidad" siguiendo el ejemplo que te he dejado arriba (puedes asignar 1 o -1 a las variables movimientoX y movimientoY para saber si se mueven izquierda, derecha, arriba o abajo)

        Intenta resolver el ejercicio, si no lo consigues guíate por la pestaña "solución", pero no la copies y pegues, consulta la solución, entiéndela y luego intenta resolverlo de nuevo por ti mismo/a.

=== "Solución"

    ```csharp
    public class PlayerController : MonoBehaviour
    {
        float velocidad = 0.02f;

        void Start()
        {

        }

        void Update()
        {
            float movimientoX = 0;
            float movimientoY = 0;

            if (Keyboard.current.aKey.isPressed || Keyboard.current.leftArrowKey.isPressed)
            {
                movimientoX = -1;
            }
            else if (Keyboard.current.dKey.isPressed || Keyboard.current.rightArrowKey.isPressed)
            {
                movimientoX = 1;
            }

            if (Keyboard.current.wKey.isPressed || Keyboard.current.upArrowKey.isPressed)
            {
                movimientoY = 1;
            }
            else if (Keyboard.current.sKey.isPressed || Keyboard.current.downArrowKey.isPressed)
            {
                movimientoY = -1;
            }

            transform.position = new Vector3(
                transform.position.x + movimientoX * velocidad * Time.deltaTime,
                transform.position.x + movimientoY * velocidad * Time.deltaTime,
                transform.position.z
            );
        }
    }
    ```

Otra posible solución sin usar movimientoX y movimientoY podría ser crear un Vector3 o Vector2 y guardar el movimiento que realiza el personaje ahí:

```csharp
void Update()
{
    Vector3 movimiento = new Vector3(0, 0, 0);

    if (Keyboard.current.aKey.isPressed || Keyboard.current.leftArrowKey.isPressed)
    {
        movimiento.x = -1;
    }
    else if (Keyboard.current.dKey.isPressed || Keyboard.current.rightArrowKey.isPressed)
    {
        movimiento.x = 1;
    }

    if (Keyboard.current.wKey.isPressed || Keyboard.current.upArrowKey.isPressed)
    {
        movimiento.y = 1;
    }
    else if (Keyboard.current.sKey.isPressed || Keyboard.current.downArrowKey.isPressed)
    {
        movimiento.y = -1;
    }

    // Guardamos en variables la posición final que tendrá el personaje
    // aunque esto podría hacerse directamente (como en el ejemplo anterior)
    float posicionX = transform.position.x + movimiento.x * Time.deltaTime * velocidad;
    float posicionY = transform.position.y + movimiento.y * Time.deltaTime * velocidad;
    float posicionZ = transform.position.z;

    // Finalmente, asignamos a transform.position la nueva posición del personaje
    transform.position = new Vector3(posicionX, posicionY, posicionZ);
}
```

## Solucionando el problema del movimiento diagonal: Vector3.normalized
Si queremos resolver el problema del movimiento diagonal, la clase `Vector3` tiene un método *normalized()* que hace el trabajo por nosotros. Primero de todo, **vamos a recordar el problema**.

Cuando nos movemos 1 punto en horizontal y 1 punto en vertical, nos movemos 2 puntos. Esto es lo que ocurre al ir en diagonal (estamos moviéndo el personaje a más velocidad de la que tendríamos si solo fuésemos en vertical o solo en horizontal).

Si usamos el código anterior (donde usamos un Vector3 para el movimiento del personaje), podríamos normalizarlo llamando a `movimiento.normalized`.

```csharp
    void Update()
    {
        Vector3 movimiento = new Vector3(0, 0, 0);

        if (Keyboard.current.aKey.isPressed || Keyboard.current.leftArrowKey.isPressed)
        {
            movimiento.x = -1;
        }
        else if (Keyboard.current.dKey.isPressed || Keyboard.current.rightArrowKey.isPressed)
        {
            movimiento.x = 1;
        }

        if (Keyboard.current.wKey.isPressed || Keyboard.current.upArrowKey.isPressed)
        {
            movimiento.y = 1;
        }
        else if (Keyboard.current.sKey.isPressed || Keyboard.current.downArrowKey.isPressed)
        {
            movimiento.y = -1;
        }

        print("Movimiento sin normalizar:\t " + movimiento);

        movimiento = movimiento.normalized;

        print("Movimiento normalizado:\t " + movimiento);
        
        float posicionX = transform.position.x + movimiento.x * Time.deltaTime * velocidad;
        float posicionY = transform.position.y + movimiento.y * Time.deltaTime * velocidad;
        float posicionZ = transform.position.z;

        transform.position = new Vector3(posicionX, posicionY, posicionZ);
    }
```

!!! Note "Ejercicio"
    1. Examina el código anterior y pruébalo. Luego ejecuta el juego y mueve el personaje en horizontal, vertical y diagonal.
    2. Mientras mueves el personaje en todas direcciones revisa la consola. Verás el vector de movimiento antes y después de llamar a "normalized()".

Como verás, al llamar a `normalized` el valor del vector cambia al moverse en diagonal adaptándose para que su velocidad sea siempre la misma cuando multipliques por la velocidad.