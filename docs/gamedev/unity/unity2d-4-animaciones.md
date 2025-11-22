Podemos mejorar un poco el sistema de movimiento de Unity y, en lugar de preguntar por la tecla que pulsar (w, a, s, d...) podemos definirlas en Unity con un nombre ("Movimiento", "Salto", "Ataque"...) y asignarles ahí mismo las teclas. Luego desde el script leer el valor.

En [este enlace](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.15/manual/QuickStartGuide.html) puedes ver un ejemplo de cómo detectar las teclas pulsadas de una forma más limpia.

En el siguiente vídeo se explica tanto como mejorar un poco la detección de teclas pulsadas (para eventos como moverse o saltar) y cómo crear animaciones en Unity.

![type:video](https://youtube.com/embed/fT0EbU_HgLU)

!!! Ejercicio
    1. Crea un nuevo proyecto en Unity 2D.
    2. Añade varias plataformas al juego (estáticas).
    3. Modela el movimiento del jugador siguiendo las explicaciones del vídeo. Asegúrate de que el salto funcione correctamente.
    4. Implementa las animaciones del jugador (parado, correr, saltar).

    **Opcionalmente**, implementa también lo siguiente: 

    5. Añade una plataforma movible a tu proyecto de manera que, duplicándola varias veces, siga funcionando correctamente. Para esto tendrás que programarla tal y como se indica en la segunda forma del vídeo.
    6. Duplica la plataforma anterior (de manera que tengas 3-4 plataformas movibles).
    7. Opcional: intenta ahora crear una plataforma que se caiga cuando el jugador se suba a ella. Tendrás que saltar de ella rápido para escaparte!