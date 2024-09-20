# Actividad II: navegador de archivos sencillo
Crea un navegador de archivos simple en la consola de Java (mediante un menú) que permita realizar las siguientes operaciones:

## Listar ficheros
Cuando inicias el programa se guardará la ruta actual y mostrará la lista de archivos y carpetas existentes en él.

## Lectura de un fichero o directorio
Si se introduce la palabra "cd” y una ruta absoluta: 

- En caso de corresponder a un directorio se mostrarán los archivos y directorios contenidos en él. 
- En caso de corresponder a un fichero se mostrará su contenido.

## Leer el principio de un fichero
Si se introduce la palabra "head” se preguntará un nombre de fichero, en caso de existir se mostrarán las 10 primeras líneas (en caso contrario se indicará que no existe).

## Crear un directorio
Si se escribe "mkdir” se debe preguntar al usuario el nombre del directorio y la ruta donde se desea crear.

## Crear un fichero (con contenido)
Si se escribe "file” se pregunta al usuario el nombre del fichero y la ruta donde se desea crear. Si esto es válido pregúntale al usuario que contenido desea añadir al mismo.

## Añadir contenido a un fichero
Si se escribe "add-text" preguntarás al usuario la ruta del fichero y el texto que quiere añadirse. Se añadirá después del último carácter que haya escrito en el fichero.

## Eliminar un fichero o directorio
Si se escribe "rm" pide una ruta y se elimina el fichero o directorio correspondiente a la misma.

## Salir del programa
Si se escribe "salir" se termina el programa.