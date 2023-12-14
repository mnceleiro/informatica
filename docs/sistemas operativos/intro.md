Tres puntos:
- El sistema operativo NO es imprescindible. Las consolas de cartuchos antiguas no tienen sistema operativo, se les mete un cartucho y lo único que hacen es ejecutar lo que hay metido dentro. Se apagan directamente en el botón.
- Proporcionar interfaz (IU o GUI).
- Gestionar almacenamiento.
- Un SO proporciona multitarea.

El sistema operativo, sobre un proceso, decide cuáles se ejecutan, cuando, qué acceso tienen al hardware, qué pueden hacer estos procesos con el hardware y, por tanto, el SO tiene que proporcionar seguridad.

Además, nos tiene que dar interfaz al usuario: gráfica (GUI) o texto.

Gestionar el almacenamiento: los procesos usan el almacenamiento, pero es un poco diferente. Los sistemas operativos son compatibles con algunos sistemas de almacenamiento y no con otros. Algunos sistemas de almacenamiento son:
- EXT4: incompatible con Windows (salvo app externa). No podemos arrancar con esto.
- NTFS
- exFAT

## Gestión de almacenamiento
Windows:
- FAT32
- NTFS
- exFAT

Linux
- ext4: buen sistema de ficheros sin ninguna limitación notable.

### NTFS
Microsoft sacó NTFS con licencia propietaria. Para tenerla debes pagar y tener autorización de Microsoft.

A día de hoy cualquier cosa es practicamente siempre compatible con NTFS sin tener por qué pagarle royalities a Microsoft. Aún así, a día de hoy aún te puedes encontrar cosas no compatibles

### Alternativa a NTFS: exFAT
Sin ninguna limitación práctica, el único problema y por qué no está más implementado es porque está registrado por Microsoft para sacar algo compatible con exFAT. A pesar de ser un sistema de ficheros más sencillo que NTFS y debería llevarse mejor con sistemas de bajos recursos es más difícil encontrar dispositivos compatibles con exFAT que con NTFS.

### FAT32
Completamente obsoleto, viene de Windows 95.

!!! Nota

    Para hacernos una idea, una de las grandes novedades de FAT32 es que permite escribir nombres de más de 8 caracteres y sin espacios.
