# Gestión de ficheros en Java
Cuando accedemos a un fichero desde Java este delega luego en el sistema operativo (este comprueba que el fichero no esté ya abierto por otro proceso, permisos, etc.). Si todo está correcto obtenemos los metadatos del fichero.

En Java existen varios paquetes para gestión de ficheros:

- java.io: File, InputStream, FileInputStream, OutputStream, FileOutputStream, Reader, FileReader, Writer, FileWriter, BufferedReader, BufferedWriter, BufferedInputStream, BufferedOutputStream...
- java.nio: Buffer, Channel
- java.nio.2: Path (interfaz), Files, FileSystem, FileSystems, Paths. Paths y Files contiene solamente métodos estáticos que retornan objetos de tipo "Path" (Path es una interfaz).

## Clase File
### Creando un fichero
```java
String filename = "ficheros/test.csv";
File f = new File(filename);

boolean createdSuccessfully = f.createNewFile(); // (1)!

System.out.println(createdSuccessfully ?
  "Fichero creado con éxito." :
  "No se ha podido crear el fichero."
);

```

1. Falta la captura de excepciones. Por limpieza del código se omitirán en la mayoría de casos.

!!! Note "Ejercicio"
    1. Añade la captura de excepciones necesarias al programa anterior.
    2. Revisa en qué ruta se ha creado el fichero y por qué.
    3. Comprueba qué ocurre si pones delante de la ruta una "/".

Vamos ahora a cargar un fichero del sistema e imprimir la ruta donde se encuentra:
=== "Código"

    ```java
    // Probamos dos llamadas al método
    printPath("files/testing.csv");
    printPath("/files/testing.csv");

    ...
    private static void printPath(String path) {
        File f = new File(path);
        System.out.println(f.getAbsolutePath());
    }
    ```

=== "Resultado"

    ```
    C:\Users\mnceleiro\IdeaProjects\file-test-project\files\testing.csv
    C:\files\testing.csv
    ```

## Comprobando la raíz de sistema
La raíz es distinta en Windows (C/D/E...) y GNU/Linux (/). Podemos usar lo siguiente para ver la raíz (o las raices del sistema):

```java title="Imprime todos los directorios raíz del sistema."
private static void printAllSystemRoots() {
    for (File f : File.listRoots()) {
        System.out.println(f);
    }
}
```


Podemos usar también la Stream API de Java e imprimirlas con un foreach:

=== "Código"

    ```java
    Arrays.stream(File.listRoots()).forEach(System.out::println);
    ```
=== "Resultado"

    ```
    C:\
    D:\
    M:\
    N:\
    O:\
    W:\
    X:\
    Y:\
    Z:\
    ```

Si quereis revisar otros métodos del API de java.io.File [podéis revisar el API de Java](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html).

## Actividad II: navegador de archivos sencillo
Crea un navegador de archivos simple en la consola de Java (mediante un menú) que permita realizar las siguientes operaciones:

### Listar ficheros
Cuando inicias el programa se guardará la ruta actual y mostrará la lista de archivos y carpetas existentes en él.

### Lectura de un fichero o directorio
Si se introduce la palabra "cd” y una ruta absoluta:

- En caso de corresponder a un directorio se mostrarán los archivos y directorios contenidos en él.
- En caso de corresponder a un fichero se mostrará su contenido.

### Leer el principio de un fichero
Si se introduce la palabra "head” se preguntará un nombre de fichero, en caso de existir se mostrarán las 10 primeras líneas (en caso contrario se indicará que no existe).

### Crear un directorio
Si se escribe "mkdir” se debe preguntar al usuario el nombre del directorio y la ruta donde se desea crear.

### Crear un fichero (con contenido)
Si se escribe "file” se pregunta al usuario el nombre del fichero y la ruta donde se desea crear. Si esto es válido pregúntale al usuario que contenido desea añadir al mismo.

### Añadir contenido a un fichero
Si se escribe "add-text" preguntarás al usuario la ruta del fichero y el texto que quiere añadirse. Se añadirá después del último carácter que haya escrito en el fichero.

### Eliminar un fichero o directorio
Si se escribe "rm" pide una ruta y se elimina el fichero o directorio correspondiente a la misma.

### Salir del programa
Si se escribe "salir" se termina el programa.

## Actividad III: Visualización de datos COVID

### Contexto
En 2020, Daniel González Peña, profesor la escuela superior de ingeniería informática en Ourense realizó una recopilación, día a día, de los datos de la incidencia del COVID en Galicia y los centralizó [en un repositorio de GitHub](https://lipido.github.io/galicia-covid19/).

Descarga el fichero CSV con la incidencia del COVID en centros educativos ordenados por fecha disponible [aquí](https://raw.githubusercontent.com/lipido/galicia-covid19/master/centros_educativos/centros_educativos.csv).

### Ejercicio
Crea una aplicación en Java que cargue el CSV y muestre por pantalla un menú con las siguientes opciones:

- Obtener todos los datos por nombre del centro educativo.
- Obtener datos por ayuntamiento y fecha (se pedirá ayuntamiento, día, mes y año, numéricos).
- Obtener la lista de centros cerrados indicando el número de casos activos y la fecha.
