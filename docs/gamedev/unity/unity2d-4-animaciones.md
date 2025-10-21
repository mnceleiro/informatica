# Sistema de entrada de Unity y animaciones

## Eventos de teclado y animaciones
Podemos mejorar un poco el sistema de movimiento de Unity y, en lugar de preguntar por la tecla que pulsar (w, a, s, d...) podemos definirlas en Unity con un nombre ("Movimiento", "Salto", "Ataque"...) y asignarles ahí mismo las teclas. Luego desde el script leer el valor.

En [este enlace](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.15/manual/QuickStartGuide.html) puedes ver un ejemplo de cómo detectar las teclas pulsadas de una forma más limpia.

En el siguiente vídeo se explica tanto como mejorar un poco la detección de teclas pulsadas (para eventos como moverse o saltar) y cómo crear animaciones en Unity.

!!! Ejercicio
    1. Descarga los [recursos del jumper pack de Kenney.nl](https://kenney.nl/assets/jumper-pack). En estos recursos están tanto los conejos del vídeo como diversas plataformas, trampas y otros coleccionables.
    2. Añade al juego una carpeta "Sprites" y dentro de ella crea las carpetas "Plataformas" y "Jugador". Arrastra algunas de las plataformas del jumper pack que has descargado (carpeta PNG/Environment) al proyecto (ponlas en la carpeta pltaformas) y los sprites del jugador a la carpeta "Jugador".
    3. Añade varias plataformas al juego (estáticas).
    4. Mira detenidamente (y trabaja) el vídeo siguiente.

![type:video](https://youtube.com/embed/fT0EbU_HgLU)


!!! Ejercicio
    1. Añade una plataforma movible a tu proyecto de manera que, duplicándola varias veces, siga funcionando correctamente. Para esto tendrás que programarla tal y como se indica en la segunda forma del vídeo.
    2. Duplica la plataforma anterior (de manera que tengas 3-4 plataformas movibles).
    3. Opcional: intenta ahora crear una plataforma que se caiga cuando el jugador se suba a ella. Tendrás que saltar de ella rápido para escaparte!