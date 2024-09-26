# Gestión de ficheros
Cuando accedemos a un fichero desde Java este delega luego en el sistema operativo (este comprueba que el fichero no esté ya abierto por otro proceso, permisos, etc.). Si todo está correcto obtenemos los metadatos del fichero.

En Java existen varios paquetes para gestión de ficheros:
- java.io: File, InputStream, FileInputStream, OutputStream, FileOutputStream, Reader, FileReader, Writer, FileWriter, BufferedReader, BufferedWriter, BufferedInputStream, BufferedOutputStream...
- java.nio: Buffer, Channel
- java.nio.2: Path (interfaz), Files, FileSystem, FileSystems, Paths.

