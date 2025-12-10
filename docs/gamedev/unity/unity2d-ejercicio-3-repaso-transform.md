# Ejercicios de repaso de Unity
## Ejercicio 1: programación básica y transform
## GameObjects y componente transform de los GameObjects
1. Crea un jugador (un cuadrado) y ponle de nombre "Player".
2. Posiciona desde código el player en el punto (-1, -2).
3. Mueve el jugador a la derecha continua y lentamente y observa como cambia su transform.position.
4. Vuelve a color al jugador en la coordenada (-1, -2).

## Ligando un script a un GameObject: entender y usar los métodos Start() y Update()
4. Crea un nuevo script de nombre ObjetoEnMovimiento.
5. Liga el script al jugador.
6. Haz que el jugador se mueva desde la coordenada en la que está hacia la derecha indefinidamente (sin pulsar nada, solo tiene que moverse a la derecha desde que ejecutas el juego).
7. Aumenta la velocidad en cada frame un poquito (que vaya un poco más rápido).
8. Cuando llegues a la posición 9 en x haz que el jugador se pare.
9. Ahora, haz que cuando llegues a la posición 9 el jugador se mueva hacia atrás.
10. Cuando llegues a -9, vuelve hacia adelante.
11. Ahora, cambia el nombre del GameObject de "Player" a "Enemigo". 

## Sprites y colliders
12. Busca un sprite en internet de algún enemigo (p. ej: puedes buscar Goomba de Mario Bros: "Goomba sprite").
13. Pon el Sprite al enemigo. Seguramente el Goomba que has descargado sea pixel art (pixelado). En este caso, asegúrate de que la imagen no tiene filtro (no filter), esto hace que Unity no la suavice.
12. Enhorabuena, has creado un enemigo que se mueve a la izquierda y derecha!
12. Modifica lo que has hecho para usar Translate en lugar de transform (Translate es más sencillo).

## Ejercicio 2: movimiento del jugador
Puedes usar un RigidBody2D para modelar el movimiento.

1. Crea un nuevo GameObject llamado "Jugador" (recuerda, al anterior le hemos cambiado el nombre a "Enemigo" así que ya no es jugador).
2. Crea un script llamado MovimientoJugador y asígnalo al jugador.
3. Haz que el jugador se mueva izquierda, derecha, arriba y abajo utilizando el InputSystem de Unity.
4. Haz que la velocidad se pueda configurar desde el inspector.
5. Añade un límite para que el jugador no pueda salir de la pantalla (no podrá seguir moviéndose en ese límite).

## Ejercicio 3: crear un enemigo que persiga
No uses físicas (RigidBody2D) para modelar el movimiento (usa el transform/Translate). Si necesitas añadir el RigidBody2D al enemigo por alguna razón puedes hacerlo, pero no lo uses en el script:

1. Crea un GameObject llamado "Enemigo2".
2. Ponle un Sprite cualquiera.
3. Añádele un script PersecucionJugador.
4. Haz que ese enemigo siga al jugador. Pista de código aproximada que podrías seguir:

```csharp
Vector3 direccion = jugador.position - enemigo.position;
transform.position += direccion.normalized * velocidad * Time.deltaTime;
```

1. Haz que la velocidad del enemigo (y el propio enemigo) se puedan cambiar desde el inspector (SerializeField).
2. Haz que, si el enemigo se acerca mucho al jugador, deje de perseguirlo.
3. Cuando vuelva a estar lejos, lo perseguirá de nuevo.

## Ejercicio 4: trampa

1. Crea una trampa (puede ser un cuadrado).
2. Haz que rote sin parar (otro script). Para rotar puedes usar el `transform.Rotate`.
3. Crea una nueva escena solo con un texto: "Has ganado".
4. Si chocas con la trampa mueres -> pasas a la escena de "Has ganado".
5. Si es el enemigo el que choca con la trampa, muere él y tú ganas la partida (usa **la misma escena**, pero que el texto ponga: "Has perdido".).
6. Haz que, hayas ganado o perdido en esa escena haya un botón de "Reiniciar nivel".