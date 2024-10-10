# Shell scripting (parte II)

## Buenas prácticas
- Google tiene una [guía de estilo para shell scripting](https://google.github.io/styleguide/shellguide.html). 
- La documentación de [ShellCheck](https://www.shellcheck.net/). ShellCheck te permite insertar scripts y te recomienda mejoras para ellos.
- [Artículo de blog de "The Sharat's"](https://sharats.me/posts/shell-script-best-practices/) de buenas prácticas en shell scripting. Además, proporciona una plantilla de uso útil para todos tus scripts.

Vamos a mejorar algunas de las cosas que hemos visto en el apartado anterior para hacerlo más legible y funcional.

## Shell de ejecución y comentarios
Indica siempre en la primera línea con qué shell quieres ejecutar el script:

```bash
#!/bin/bash
#

Cosas...
```

## Uso de dobles comillas en las variables
Para prevenir diversos problemas, es recomendable que uses dobles comillas en las variables
=== "NO recomendado"

    ```bash title="Comprueba si es mayor de edad"
    --8<-- "docs/ficheros/scripts/ifelse/condicionais2.sh"
    ```

=== "Recomendado"

    ```bash title="Comprueba si es mayor de edad"
    --8<-- "docs/ficheros/scripts/ifelse/condicionais2-mejorado.sh"
    ```


## Operadores lógicos
Aunque hemos visto que existe la opción -o (OR), -a (AND) para unir dos condiciones entre corchetes, la forma recomendable para evitar problemas es usar && y || fuera de los corchetes. Por ejemplo:

=== "NO recomendado"

    ```bash title="Comprueba si es mayor de edad"
    --8<-- "docs/ficheros/scripts/ifelse/condicionais6.sh"
    ```

=== "Recomendado"

    ```bash title="Comprueba si es mayor de edad"
    --8<-- "docs/ficheros/scripts/ifelse/condicionais6-mejorado.sh"
    ```

## Corchetes, doble corchete, paréntesis y doble paréntesis
### Comando test y corchetes
El caracter "[" y "]" son solo una versión del comando "test". El caracter "\[" existe en /usr/bin/\[. Esta es la razón por la que necesitan un espacio después de escribirse.

Vamos a hacer pruebas con el comando test y los corchetes, para que se vea que es lo mismo.

![test command linux](../images/gnu-linux/test-command.png)

!!! Note "Ejercicio"
    Prueba los dos últimos comandos de la imagen (que son para ver el manual de los comandos "test" y "\["). Deberías ver que ambos llevan al mismo sitio.

### Doble corchete [[]]
Mejora del comando test anterior. Con doble corchete podemos usar diversos operadores o expresiones sin tener que escaparlas con la barra invertida (\\). Por ejemplo, si intentamos comparar con un operador "mayor que" o "menor que" dos números:
```bash
# Este programa falla
if [ 4 < 5 ]; then
    echo "4 es menor que 5"
fi
```

Este programa no funcionaría, sin embargo, sí podríamos hacerlo con doble corchete:
```bash
# Este programa funciona (también serviría usar corchete simple y escapar el "menor que")
if [[ 4 < 5 ]]; then
    echo "4 es menor que 5"
fi
```

https://www.warp.dev/terminus/bash-printf