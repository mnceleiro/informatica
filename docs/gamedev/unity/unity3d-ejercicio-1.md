# Ejercicio de Unity3D
Este ejercicio es similar a lo ya visto en 2D y sirve para repasarlo (solo que en este caso en el mundo 3D). Todo el ejercicio está orientado a hacerse con figuras básicas de Unity (cilindros, cápsulas, cubos, etc.)

1. Crea un proyecto de tipo Universal 3D.
2. Crea una plataforma (crea un cubo y redimensionalo para que sea más grande y delgado, será el suelo).
3. Crea al jugador (será una cápsula).
4. Añade gravedad y ejecuta el proyecto. El personaje (la cápsula) debería caer sobre la plataforma. Si no lo hace qué crees que falta hacer? Hazlo.
5. Cambia los colores de la plataforma y del jugador a dos colores diferentes. Para cambiarlos, tendrás que crear un "Material" (no Physics Material!!). Crea una carpeta material con un nuevo material y cambia el color del material a uno de tu elección. Luego, arrastra el material a la plataforma. Haz lo mismo para el jugador.
7. Movimiento: crea un script PlayerMovement y [usa el nuevo InputSystem de Unity para hacer el movimiento del jugador](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.17/manual/QuickStartGuide.html). Ten en cuenta que cuando detectes el movimiento en la tecla "w" ya no tendrás que mover al personaje en el eje "y" (como hacías en 2D) sino en z (piénsalo, puede ser lioso de comprender).
8. Haz que la cámara siga al jugador (usa la perspectiva que quieras: desde atrás, lateral, etc.). La más típica sería verlo desde atrás y seguirlo.
9.  Tenemos el problema de que movemos el personaje, pero este no gira. Hasta ahora, habíamos usado del nuevo InputSystem de Unity el "Move" y el "Jump". Para girar con el ratón tendrás que usar el "Look" (ya viene predefinido) de la misma forma que usabas "Move". Luego, usar el método `transform.Rotate(...)` para girarlo según el valor que obtienes de "Look".
10. Una vez el personaje se mueva, mira que tu personaje no se quede anclado al lateral de la plataforma al caer (fricción). Si lo hace, tendrás que crear un nuevo Physics Material y arrastrarlo a la plataforma para eliminar la fricción.
11. Crea una plataforma ascensor (se mueve arriba y abajo).
12. Implementa el salto (investiga en internet, hay varias maneras!).
13. Crea un prefab de la plataforma. Luego, duplica la que tienes y muévela para crear un pequeño mundo de figuras (saltar entre plataformas). Puedes manipular forma, altura, color, material...
14. Aplica movimiento a algunas de las plataformas (lo puedes hacer de la forma que ya sabes, con 2 puntos y un script de movimiento).
15. Crea 3 o 4 monedas (no necesitas sprites, solo figuras). Recolecta esas monedas y cuéntalas de la misma forma que lo haces en 2D.
16. Crea un portal (usa cualquier figura) para el final. Cuando toques el portal irás a una pantalla de FIN del juego.
17. Exporta el juego.

## Extras (no hay que hacerlos)
Esto no hay que hacerlo, lo dejo por si alguien aún quiere darle más caña a Unity. El 10 está en hacer lo anterior.

- Crea trampas. Por ejemplo, pinchos (unos conos en los que si caes mueres).
- Crea un par de checkpoints (p. ej: una especie de bandera con un cilindro cubo como palo y otro de bandera), de manera que en una zona difícil, si te caes o mueres. Esto puede ponerse. por ejemplo, antes de alguna trampa o un salto difícil.
- Investiga tutoriales sobre como usar "Cinemachine". Cinemachine es una cámara más potente que se puede usar tanto para 2D como para 3D y que puedes instalar en tu proyecto.
- Pon sonidos al coger cosas o chocar con pinchos.
- Pon vidas.
- Haz que, alguna plataforma especial, al estar sobre ella un tiempo desaparezca.
- Haz un enemigo que te persiga. Esto puedes hacerlo con Vector3.MoveTowards cuando lo tengas a cierta distancia o esteis sobre una misma plataforma.
- Haz que, si mueres, te de la opción de "Salir", "Reiniciar desde último checkpoint" o "Reiniciar desde el principio".
