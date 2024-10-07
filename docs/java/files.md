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
    1. Añade la captura de excepciones necesarias a l programa anterior.
    2. Revisa en qué ruta se ha creado el fichero y por qué.
    3. Comprueba qué ocurre si pones delante de la ruta una "/".

Vamos ahora a cargar un fichero del sistema e imprimir la ruta donde se encuentra:
=== "Código"

    ```java
    // Probamos dos llamadas al método
    System.out.println("=== RUTA ABSOLUTA DEL FICHERO \"testing.csv\" ===");
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
    === RUTA ABSOLUTA DEL FICHERO "testing.csv" ===
    C:\Users\mnceleiro\IdeaProjects\file-test-project\files\testing.csv
    C:\files\testing.csv
    ```

La clase File tiene un método para comprobar si el fichero existe:

```java
private static void printPath(String path) {
    File f = new File(path);

    if (f.exists()) {
        System.out.println(f.getAbsolutePath());
    } else {
        System.out.println("El fichero no existe.");
    }
}
```

### Comprobando la raíz de sistema
La raíz es distinta en Windows (C/D/E...) y GNU/Linux (/). Podemos usar lo siguiente para ver la raíz (o las raices del sistema):

```java title="Imprime todos los directorios raíz del sistema."
private static void printAllSystemRoots() {
    for (File f : File.listRoots()) {
        System.out.println(f);
    }
}

public static void main(String[] args) {
    printAllSystemRoots();
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


### Otros métodos de File
Algunos de los más interesantes son los siguientes:

| Retorno   | Método |
| :-: | :-: |
| boolean   | canRead() |
| boolean   | canWrite() |
| boolean   | canExecute() |
| boolean   | createNewFile() |
| boolean   | delete() |
| boolean   | exists() |
| boolean   | isDirectory() |
| boolean   | isFile() |
| boolean   | isHidden() |
| boolean   | mkdir() |
| File      | getAbsolutePath() |
| File      | getCanonicalPath() |
| File[]    | listFiles() |

## Clase Files (java.nio)
La clase Files sirve más o menos para lo mismo que File, pero en este caso contiene todo métodos estáticos y recibe un **Path** como parámetro.

No tienes que saberlos de memoria, si quieres realizar alguna operación puedes usar tu IDE o internet para ver como hacerla. También, si quereis ver más información u otros métodos de java.io.File [podéis consultar el API de Java](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html).

## Actividad II: java.nio.Files
Completa la siguiente tabla usando solo métodos de java.nio.Files y escribe un programa muy simple que pruebe 5 de ellos y otros 5 distintos que te parezcan interesantes del [API de Java](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html)).

La dificultad añadida de "Files" es que siempre recibe como parámetro un ["Path"](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Path.html). [Aquí dejo un buen artículo de internet como apoyo](https://javarush.com/en/groups/posts/en.2275.java-files-path).

| Retorno   | Método clase File     | Método clase Files/Path   |
|   :-:     |       :-:             |       :-:                 |
| boolean   | canRead()             |   -                       |
| boolean   | canWrite()            |   -                       |
| boolean   | canExecute()          |   -                       |
| boolean   | createNewFile()       |   -                       |
| boolean   | delete()              |   -                       |
| boolean   | exists()              |   -                       |
| boolean   | isDirectory()         |   -                       |
| boolean   | isFile()              |   -                       |
| boolean   | isHidden()            |   -                       |
| boolean   | mkdir()               |   -                       |
| File      | getAbsolutePath()     |   -                       |
| File      | getCanonicalPath()    |   -                       |
| File[]    | listFiles()           |   -                       |

## Actividad III: navegador de archivos sencillo
Crea un navegador de archivos simple en la consola de Java (mediante un menú) que permita realizar las siguientes operaciones:

### Arranque del programa
Cuando inicias el programa se guardará la ruta actual y mostrará:
- La ruta absoluta actual.
- La lista de archivos y carpetas existentes en la ruta.

### Listar ficheros
Si escribes la palabra "ls" se mostrará la lista de archivos en la carpeta actual.

### Lectura de un fichero o directorio
Si se introduce la palabra "cd" y una ruta absoluta pueden pasar dos cosas:

- En caso de corresponder a un directorio se mostrarán los archivos y directorios contenidos en él.
- En caso de corresponder a un fichero se mostrará su contenido.

### Leer el principio de un fichero
Si se introduce la palabra "head" se preguntará un nombre de fichero, en caso de existir se mostrarán las 10 primeras líneas (en caso contrario se indicará que no existe).

### Crear un directorio
Si se escribe "mkdir" se debe preguntar al usuario el nombre del directorio y la ruta donde se desea crear.

### Crear un fichero (con contenido)
Si se escribe "file" se pregunta al usuario el nombre del fichero y la ruta donde se desea crear. Si esto es válido pregúntale al usuario que contenido desea añadir al mismo.

### Añadir contenido a un fichero
Si se escribe "add-text" preguntarás al usuario la ruta del fichero y el texto que quiere añadirse. Se añadirá después del último carácter que haya escrito en el fichero.

### Eliminar un fichero o directorio
Si se escribe "rm" pide una ruta y se elimina el fichero o directorio correspondiente a la misma.

### Salir del programa
Si se escribe "salir" se termina el programa.

## Actividad IV: XML
Crea un nuevo proyecto con una clase "Mascota" con los atributos:

- id: long
- breed: String
- name: String
- type: String
- color: String

### Conversiones entre XML y objetos Java
Crea una clase "Principal" con un método "main" y crea un objeto Mascota. Después, conviértelo a XML de manera que consigas una salida como esta por consola:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<pet id="1">
    <nombre>Darwin</nombre>
    <tipo>gato</tipo>
    <raza>Siamés</raza>
    <color>gris</color>
</pet>
```

- Haz que el XML anterior se almacene en un fichero en vez de por salida estándar (stdout).
- Obtén el XML almacenado en el fichero y conviértelo en un objeto Mascota.

### Organización de código y uso de genéricos
Organiza el código en clases de manera que tengas:

- Una clase **ConversorJaxbDeObjetoAXml** con métodos que reciban objetos mascota y realicen lo siguiente:
    - Almacenar mascota en fichero.
    - Mostrar por salida estándar (consola).
- Una clase **ConversorJaxbDeXmlAObjeto** con métodos que reciban un XML y realicen lo siguiente:
    - Obtener objeto de fichero.
- Haz que el código utilizado sirva para cualquier otra clase (no solo para Mascota). Para esto necesitas utilizar genéricos.


## Actividad V: Manipulación de JSON

![type:video](https://www.youtube.com/embed/kHw85khzcKE)

### Conversión entre JSON y objetos Java
Crea un nuevo proyecto con una clase mascota con los atributos:

- id: long
- breed: String
- name: String
- type: String
- color: String

Crea una clase "Principal" con un método "main" y crea un objeto Mascota. Después, conviértelo a JSON utilizando GSON o Jackson de manera que consigas una salida como esta por consola:

```json
{
  "mascota" : {
    "id" : 1,
    "nombre" : "Darwin",
    "tipo" : "gato",
    "raza" : "Siamés",
    "color" : "gris"
  }
}
```

Finalmente, cambia el nombre de la mascota y realiza la transformación inversa (convierte el json generado a un objeto "Mascota" nuevamente).

### Organización de código y uso de genéricos
Crea una interfaz ConversorORMJson con las definiciones de los siguientes métodos:
1. **aObjeto**(String json): Mascota
2. **aJson**(Mascota m): String

Posteriormente, crea una clase **ConversorORMGson** o **ConversorORMJackson** (según qué biblioteca estés usando) que implemente la interfaz anterior.

Haz que la interfaz y las clases anteriores sirvan para cualquier tipo de entidad (utiliza genéricos).

## Actividad VI: Visualización de datos COVID
### Contexto
En 2020, Daniel González Peña, profesor la escuela superior de ingeniería informática en Ourense realizó una recopilación, día a día, de los datos de la incidencia del COVID en Galicia y los centralizó [en un repositorio de GitHub](https://lipido.github.io/galicia-covid19/).

Descarga el fichero CSV con la incidencia del COVID en centros educativos ordenados por fecha disponible [aquí](https://raw.githubusercontent.com/lipido/galicia-covid19/master/centros_educativos/centros_educativos.csv).

### Visualización en consola
Crea una aplicación en dos capas (dos paquetes, iu y datos), donde las clases de la capa de IU se ocupen de mostrar un menú para las siguientes opciones:

- Obtener todos los datos ordenados por el nombre del centro educativo.
- Obtener todos los datos de un solo día indicado (el día será 1, 2, 3...). Tendrás que agruparlos.
- Obtener datos por ayuntamiento y fecha (se pedirá ayuntamiento, día, mes y año, numéricos).
- Obtener la lista de centros cerrados indicando el número de casos activos y la fecha.

Todas las operaciones de ese menú tendrán que realizarse con funciones en la capa de datos (en este ejercicio solo usaremos una clase a la que vamos a llamar DatosCovidDao). Ahí tendrás que realizar todas las operaciones.

### Visualización en web dinámica
Crea una aplicación en Java que cargue el CSV en memoria con cada petición GET a /datoscovid con las siguientes operaciones:

- /datoscovid/all: Obtener todos los datos ordenados por el nombre del centro educativo.
- /datoscovid/all?page={dia}: Obtiene los datos del primer día disponible (si se pasa en dia un 1), si se pasa un 2 será el segundo día, etc.
- /datoscovid/all?centro={nombre}: Obtiene los datos históricos del centro educativo, si existe.
- /datoscovid/all?ayuntamiento={nombre}: Obtener datos por ayuntamiento.
- /datoscovid/all?cerrado=1 (o cerrado=0): Obtener la lista de centros cerrados.

Puedes aprovechar la capa de datos anterior.


## TODOs futuros (mejoras)
- Separar completamente ejercicios que usan java.io y java.nio. Intentar buscar buen contenido externo que enlazar sobre esto, ya que es enrevesado (o simplemente restarle importancia).
- Más ejemplos con java.nio y java.nio2
- Optimizar o reducir la parte de XML. Pensar en dar opción entre librerías (JAXB y XStream)
- Un posible inicio de proyecto.
- Buenas referencias externas para crear una webs dinámicas en Java. Tomcat.