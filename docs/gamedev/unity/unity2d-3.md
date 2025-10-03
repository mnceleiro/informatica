## Creando plataformas
Hace un rato hemos explicado como añadir figuras (cuadrados, triángulos, etc.) a nuestro juego de dos formas diferentes (crear el GameObject vacío y añadir el Sprite Renderer o añadirlo directamente desde el menú).

Si añadimos un cuadrado y modificamos el tamaño (escala) del mismo, podemos hacerlo parecer una plataforma. 

![Conejo y tres plataformas](images/unity-conejo-3-plataformas-rectangulares.png)

!!! Note "Ejercicio"
    Crea tres plataformas rectangulares sobre las que, en el futuro, nuestro personaje pueda subirse:
    
    - Una de ellas hazla creando un cuadrado directamente desde el menú.
    - Las otras dos creando un GameObject vacío y luego añadiendo el componente con la imagen de un cuadrado (a ver si la encuentras!).

## RigidBody2D
**Rigidody2D** es un componente para hacer que tu objeto se rija por las leyes de la física (se le puedan aplicar fuerzas, al moverse no se frena de golpe, sino gradualmente, es afectado por la gravedad, rebota al chocar...).

![RigidBody2D](images/unity-rigidbody2d.png)

!!! Note "Ejercicio"
    1. Añade un RigidBody2D a tu personaje y ejecuta el juego. Importante que sea el de 2D!

Cuando hagas esto, deberías ver que el personaje se cae hasta el abismo infinito.

- Esto es porque en el momento en que añadimos el RigidBody2D nuestro GameObject se ve afectado por la gravedad. 
- También, el personaje atraviesa las plataformas. Esto se debe a que lo que hemos añadido a la escena son solo GameObjects con una posición y una imagen (Sprite), pero no tienen ningún comportamiento añadido para indicar las colisiones.

## Objetos de colisión: colliders
Para añadir colisiones disponemos en Unity de los **colliders** y existen de varios tipos: BoxCollider2D (forma rectangular), CapsuleCollider2D (forma de cápsula), etc.

En este caso, para crear un BoxCollider 2D tenemos que:

Pulsar en el **GameObject del personaje -> Add Component -> BoxCollider2D**.

![Edit collider](images/unity-edit-collider.png)

Después, podemos seleccionar el cuadrado verde alrededor del personaje para modificar su superficie de colisión.

!!! Note "Ejercicio"
    1. Añade un collider al personaje.
    2. Ejecuta el juego, ¿ha caído el conejo encima de la plataforma?
    3. Añade lo que falta para que el conejo caiga en la plataforma. Pista: quizá tengas que añadir algún tipo de colisión a las plataformas.