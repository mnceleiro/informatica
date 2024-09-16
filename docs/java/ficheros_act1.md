# Actividad: Visualización de datos COVID

## Parte I: ejercicios guiados sobre formatos de ficheros
![type:video](https://www.youtube.com/embed/UKBDUpXEY_0)

### Extensiones de ficheros en Windows
1. Accede a una carpeta de tu sistema que contenga ficheros. Posteriormente, pulsa en: *"Ver" → "Extensiones de nombre de archivo" (márcala y desmárcala)*.
2. Observa como las extensiones de fichero aparecen y desaparecen.
3. Crea un fichero de texto plano de nombre hola.txt y escribe algo dentro. Posteriormente guárdalo y abrelo. ¿Con qué programa se abre por defecto el fichero?
4. Quita la extensión al fichero y llámale solo hola. ¿Qué ocurre si intentas abrirlo?
5. Investiga qué ocurre si intentas abrir un fichero de texto sin extensión y por qué.
6. Crea un fichero en Word o Writer, escribe un par de palabras y guárdalo con el nombre prueba.odt (o prueba.docx si usas Word).
7. Cámbiale la extensión a .PNG y abrelo con doble click, ¿qué ocurre y por qué?
8. Ahora, intenta, sin cambiarle el nombre ni la extensión, abrirlo con Writer o Word. ¿Es posible hacerlo o el fichero está corrupto?

### Tipos de ficheros: CSV
CSV significa “Comma-separated-values” o “valores separados por comas”. Es una manera de guardar información en un fichero de forma sencilla y posteriormente visualizarla. Realiza las siguientes tareas:

 1. Accede a esta página (https://es.wikipedia.org/wiki/Anexo:Municipios_de_Espa%C3%B1a_por_poblaci%C3%B3n) que muestra los municipios de España. 
 2. Crea un fichero de texto y añade los datos tres municipios al mismo (recuerda, cada dato separado por comas y cada municipio en una línea).
 3. Guarda el fichero con el nombre municipios.csv.
 4. Abre el fichero con el programa LibreOffice Calc y comprueba que se muestra correctamente. Si no se muestra bien modifícalo hasta que así sea.
 5. Abre el fichero con Microsoft Excel, ¿se muestra correctamente?

### Tipos de ficheros: XML
Escribe un listado con tres series o películas de televisión que te gusten (debe haber al menos una serie y al menos una película). Recuerda que todo XML debe tener una única raíz, es decir, un elemento que contenga todo lo demás.
Se pide que cada serie o película tenga los siguientes elementos:

- Nombre.
- Año.
- Número de temporadas (solo si es una serie)
- Duración (solo si es película)
- Se pide que cada película o serie tenga el siguiente atributo:
- Tipo (que puede ser solamente película o serie).

### Tipos de ficheros: JSON
Completa el siguiente fichero JSON para guardar un listado de películas y series (con los elementos del ejercicio anterior):

```
{
  "peliculas": [
{...},
{...}
  ],
    
  "series" : [
  {...},
  {...}
  ]
}
```

Si lo deseas, puedes ayudarte de un editor y validador online para crear el fichero.

### Tipos de ficheros: OpenXML, OpenDocument
Haz lo siguiente:

  1. Crea un fichero con Word (docx) o LibreOffice Writer (odt) y guárdalo.
  2. Cambia la extensión del fichero a .zip.
  3. Descomprime el ZIP y revisa lo que hay dentro.
  4. Intenta hacer lo mismo cuando almacenas el fichero en un .doc e indica su funciona o no y por qué ocurre.

### Cuestiones variadas
Verifica tus conocimientos intentando responder correctamente a las siguientes cuestiones o ejercicios:

 1. ¿Cómo se pueden mostrar u ocultar extensiones de archivos en Windows? ¿Crees que es mejor tenerlos ocultos? ¿Por qué?
 2. Escribe un fichero CSV con una lista de.. (alumnos, equipos, jugadores, películas, cines, etc.).
 3. Explica el formato de fichero CSV.
 4. Escribe tus datos personales (puedes inventarte algunos) en formato XML.
 5. Escribe tus datos personales (puedes inventarte algunos) en formato JSON.
 6. Identifica que tipo de formato sigue X fichero aportado por el profesor.
 7. Indica tres formatos de fichero binarios que conozcas.
 8. Indica tres formatos de fichero de texto que conozcas.

## Parte II: manipulación de CSVs con Java
### Contexto
En 2020, Daniel González Peña, profesor la escuela superior de ingeniería informática en Ourense realizó una recopilación, día a día, de los datos de la incidencia del COVID en Galicia y los centralizó [en un repositorio de GitHub](https://lipido.github.io/galicia-covid19/).

Descarga el fichero CSV con la incidencia del COVID en centros educativos ordenados por fecha disponible [aquí](https://raw.githubusercontent.com/lipido/galicia-covid19/master/centros_educativos/centros_educativos.csv).

### Ejercicio I
Crea una aplicación en Java que cargue el CSV y muestre por pantalla un menú con las siguientes opciones:

- Obtener todos los datos por nombre del centro educativo.
- Obtener datos por ayuntamiento y fecha (se pedirá ayuntamiento, día, mes y año, numéricos).
- Obtener la lista de centros cerrados indicando el número de casos activos y la fecha.