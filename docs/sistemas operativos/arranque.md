Al encender un ordenador arranca la BIOS y, después de esta, arranca el sistema operativo (según el orden de arranque establecido en la BIOS).

## Arranque clásico
## Arranque clásico: Legacy + MBR (Master Boot Record)
El nombre del particionamiento es MBR porque hay un sector en este que se denomina así (MBR). Este señala exactamente que partición es la que lleva un sistema operativo.

1. La BIOS indica que se debe arrancar desde X disco.
2. Se mira en el MBR de ese disco, el cuál señala la partición que tiene que arrancar (la que lleva el arranque del sistema operativo).
3. Esta partición lleva un trozo denominado sector de arranque (donde se marca como tal la partición y qué tiene que hacer para arrancar el SO).

### Limitación: máximo de 4 particiones
Esto es, solo podemos trocear el disco duro en cuatro partes.

Existen dos tipos de particiones:
- Primaria: podemos instalar tanto datos como el sector de arranque.
- Extendida: solo podemos dividirla en algo llamado "unidades lógicas". En estas unidades lógicas podemos tener datos (pero no el arranque).

Una partición extendida es coger una de las cuatro disponibles y convertirla en extendida. En una partición extendida no se pueden grabar ficheros, instalar SOs, hacer particiones de arranque, etc. **Lo único que se puede hacer en una partición extendida es crear unidades lógicas.**

!!! Nota:
    Podemos partir un disco en **3 particiones primarias y una extendida**. La extendida tendrá a su vez múltiples unidades lógicas.

    **En las unidades lógicas solo se pueden guardar datos y en la primaria datos y arranque**. En una partición primaria podemos instalar sistemas operativos.

Si necesitas más de "4 trozos" podemos hacer 3 primarias y una extendida. Dentro de esta última creamos las unidades lógicas que necesitemos.

Es posible instalar múltiples sistemas operativos en particiones extendidas, pero tendríamos que instalar el arranque en una partición primaria (si borramos esa partición sin querer no podríamos arrancarlo).

## Limitación: máxima capacidad de 2TB
El máximo tamaño de partición es de 2TB.

## UEFI + GPT
GPT es un formato para particionar discos duros y, a diferencia de MBR, tiene 120 particiones primarias por disco con un máximo de 8 ZB.

!!! Nota:
    Los discos NVMe no pueden particionarse en MBR, solamente en GPT. Por tanto, necesitas el modo UEFI.

En UEFI es necesario tener una partición inicial con todos los módulos de arranque de todos los sistemas operativos del resto de particiones (gracias a esto es posible listar todos los sistemas operativos que hay en todos los discos duros).

También, en UEFI disponemos del Fast Boot y el Secure Boot:
- Secure boot: no se puede arrancar un sistema operativo en que se han hecho modificaciones. El secure boot firma digitalmente la partición.
- Fast boot: se salta todo el arranque de la BIOS y va directamente al sistema operativo.


## Legacy vs UEFI
No es posible arrancar particiones GPT si tienes la BIOS en modo Legacy. En el modo UEFI ahora se puede arrancar desde discos duros particionados en GPT.
