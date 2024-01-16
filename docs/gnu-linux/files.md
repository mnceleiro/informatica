# Manejo de ficheros y carpetas

## Creación de carpetas
```bash
# Creamos una carpeta nueva en el directorio donde nos encontramos
mkdir miNuevaCarpeta

# Creación de carpeta con nombre "nueva" con ruta absoluta
mkdir /home/mnceleiro/Documentos/nueva

# Creación de múltiples carpetas consecutivas con un solo comando (añadimos -p)
# Este comando crearía todas las carpetas de la ruta que no existan
mkdir -p Documentos/nueva/nueva2/nueva3/nueva4/nueva5/datos_empleados
```

## Eliminación de carpetas
```bash
# Elimina una carpeta vacía
rmdir nombreCarpeta
```

### Ejercicio
Intenta ejecutar el comando con una carpeta que tenga algo dentro. ¿Funciona?

!!! Nota
    Más adelante veremos como eliminar carpetas con todo lo de su interior con un solo comando.

## Crear un fichero de texto
Existen muchas maneras. Vamos a ver las siguientes:

- Con un editor de texto (Vim, Nano).
- Con el comando touch.
- Con el comando echo usando "redirecciones".

### Crear fichero con un editor de texto
Los dos editores de texto más conocidos en GNU/Linux son:
- Vim
- Nano

Teniendo el segundo una curva de aprendizaje más sencilla que el primero, pero siendo el primero probablemente más potente en general.

#### Ejercicios
- Crea en tu home el fichero miPrimerFichero.txt con el editor de texto **Nano** y usando una ruta absoluta desde tu home.
- Crea en tu home un fichero miSegundoFichero.txt con el editor de texto **Nano**, situándote antes en / y usando una ruta relativa.
- Crea en tu home un fichero miTercerFichero.txt con el editor de texto **Vim** (apt install -y vim) situándote en /home y usando una ruta relativa.

### Crear fichero con el comando touch
El comando touch sirve para cambiar la información relacionada con los timestamps de un fichero (p. ej: el último acceso, la última modificación o la creación del fichero). Además de esto se usa mucho para crearlos (ya que si uso el comando en un fichero que no exista, este se crea).

```bash
# Creando un fichero con touch
touch miPrimerFicheroConTouch.txt
ls -l miPrimerFicheroConTouch.txt

# Usando touch para cambiar los tiempos del fichero
touch -t 201812201000 miPrimerFicheroConTouch.txt

# Pero... ¿qué timestamp he cambiado? Comando stat nos ayuda
stat miPrimerFicheroConTouch.txt
```

### Crear fichero con el comando echo
El comando echo devuelve lo que le escribas a la pantalla. Es similar al comando de Java `System.out.println("Texto")`. Por defecto, ese texto se muestra en pantalla, pero **podemos redirigir el texto de la salida estándar (pantalla) a otro sitio que nosotros queramos**. En este caso lo redirigiremos a un fichero.

Prueba los siguientes comandos:
```bash

# Mostramos el texto "Hola mundo" por la salida estandar (pantalla)
echo "Hola mundo"

# Mostramos el texto "Hola mundo" pero... redirigimos SU SALIDA ESTÁNDAR a un fichero,
# por lo que se almacenará en él y no se mostrará por pantalla.
# Esto es muy práctico para crear ficheros
echo "Hola mundo" > miNuevoFichero.txt
```

*TODO: Explicar redirecciones ">" "<" ">>" o enlazar algún artículo externo.*

#### Ejercicios
- Prueba a ejecutar varias veces el comando anterior que redirige el "Hola mundo" a un fichero. ¿Cambia algo de ejecutarlo 1 a varias veces?
- Prueba ahora el mismo comando, pero en lugar de ">" utiliza ">>". ¿Qué ocurre? ¿Para qué sirve usar dos símbolos en lugar de 1?

Más información en [este enlace](https://ioflood.com/blog/touch-linux-command/).

## Ver contenido de los ficheros
### Ver todo el contenido con cat
Muestra el contenido de un fichero. La sintaxis es:

```bash
# Sintaxis básica
cat <fichero>

# Mostramos la informacion de los usuarios del sistema
cat /etc/passwd

# Ver contenido de fichero de grupos
cat /etc/group

# Ver contenido de contrasenhas (encriptadas) con los numeros de linea marcados (-n o --number)
cat -n /etc/shadow

# Ver contenido de un fichero mostrando un $ en los cambios de linea  (--show-ends o -E)
cat --show-ends fichero.txt

# Ver contenido de fichero incluyendo caracteres no imprimibles (--show-nonprinting o -v)
cat -v fichero.txt
```

!!! Nota
    Los ficheros de configuración en GNU/Linux se encuentran en la carpeta /etc. Algunos interesantes son los que verás con los comandos anteriores.

### Ver contenidos iniciales de un fichero con head)
```
# Ver informacion del procesador (10 primeras líneas)
head /proc/cpuinfo

# Listamos las 23 primeras lineas del fichero que tiene informacion de la memoria ([-n numero_lineas])
head -n 23 /proc/meminfo

# Mostramos la primera línea del fichero que tiene informacion de tiempo de encendido
head -n 1 /proc/uptime
```

!!! Nota
    En la carpeta /proc podemos encontrar información útil relacionada con el hardware y los procesos del sistema.

### Ver contenidos finales de un fichero con tail
```
# Ver últimas líneas de un fichero (en este caso el .bash_history situado en tu home)
tail /home/<usuario>/.bashrc

# Solo las 7 últimas líneas
tail -n 7 /home/<usuario>/.bashrc

# Mira las últimas 5 líneas del fichero syslog y lo recarga cada segundo (nos sirve por si cambia y queremos monitorizarlo)
tail -f -n 5 /var/log/syslog

# Ver las 12 ultimas lineas del fichero
## No podemos mostrar los numeros de linea con tail/head, asi que pasamos la salida del comando cat a la entrada de tail
cat -n .bashrc | tail -n 12
```

### Ver contenido de fichero con more
Muestra información de fichero de forma interactiva, página a página.
```
# Ver contenido fichero de logs generico: /var/log/messages o /var/log/syslog (sistemas debian y derivados)
more /var/log/syslog

# Se puede pasar la pagina con la barra espaciadora y salir con letra "q". Para mostrar esa ayuda con more -d:
more -d /var/log/syslog

# Eliminamos lineas en blanco dejando solo una (si hay 3 saltos de linea lo deja en 1)

more -s texto.txt
```

#### Ejercicio
    Prueba las opciones: -u, -p y +número (¿para qué sirven?)

### Ver contenido de fichero con less
Con el comando more la información de ficheros queda en el terminal y, en ficheros largos puede resultar bastante molesto. Con less vemos el fichero y el texto no se muestra en terminal.

```bash
# Mostramos el fichero de autenticación/autorización de GNU/Linux usando less
# (auth.log en Debian y derivados, /var/log/secure en RedHat y CentOS)
less /var/log/auth.log
```

Dentro del comando less puedes:
- Buscar cadenas (igual que hacemos en el manual, con el caracter "/" y un texto).
- Avanzar línea a línea (flechas abajo y arriba).
- Avanzar página a página (barra espaciadora).

#### Ejercicio
- Crea un fichero de 25 párrafos (un lorem ipsum) y busca alguna palabra con less.
- Avanza en el fichero línea a línea abajo y arriba.
- Avanza página a página (barra espaciadora).
- Busca en los logs de Linux los eventos de autenticación que ocurrieron el día de hoy.
- Consulta el fichero con "less" y ve directamente al final (shift + g).
- Usa el comando "su <tu-usuario>" para logearte en un terminal (esto abrirá una nueva sesión de terminal con tu usuario). Escribe MAL la contraseña. Después, busca ese evento en los logs del sistema (auth.log y faillog).

### Otros ficheros de log interesantes
Algunos interesantes diferentes a los ya vistos son los siguientes:
- **/var/log/mysqld.log** (RedHat, CentOS y Fedora) o **/var/log/mysql.log** (Debian): mensajes relacionados con MySQL.
- **/var/log/httpd/**: Logs relacionados con Apache. Existen dos ficheros: **access.log** y **error.log**.

### Ver diferencias entre dos ficheros con diff
Sintaxis:
```bash
  diff <fichero1> <fichero2>
```

## Copiado, movimiento y renombrado de ficheros
Para copiar un fichero a otro lugar **se usa el comando cp** (**c**o**p**y):

```bash
  # Copiamos el fichero miFichero.txt a la carpeta Documentos (con ruta relativa):
  cp miFichero.txt Documentos

  # Creamos varios ficheros vacíos con touch (mezclamos comillas y escapados para practicar)
  ## ESTE COMANDO TIENE UN ERROR (si haces un ls lo verás, corrígelo!)
  touch "fich 1.txt" "fich 2.txt" fich \3.txt hola.dat

  # Copiamos los ficheros fich 1.txt, fich 2.txt y hola.dat a la carpeta Documentos
  cp "fich 1.txt" "fich 2.txt" "fich 3.txt" hola.dat Documentos
```

Podemos pasar tantos ficheros de origen como queramos. El **último parámetro** siempre es el **DESTINO**.

### Copiar y renombrar al mismo tiempo

#### Copia y renombrado
En el siguiente ejemplo vamos a mezclar rutas absolutas y relativas para practicar. Creamos un fichero y lo copiamos con otro nombre.
```bash
  # Creamos un fichero saludo.txt con el texto "Hola"
  echo "Hola" > /home/<usuario>/saludo.txt

  # Lo copiamos a la carpeta Documentos cambiándole el nombre a saludar.txt (primera con ruta absoluta, segunda relativa)
  cp /home/<usuario>/saludo.txt ./Documentos/saludar.txt

  # Hacemos otra copia en la misma ruta (usamos ruta relativa)
  cp ./saludar.txt "nuevo saludo.txt"
```

Después de esto tendremos:
- Fichero saludo.txt en nuestro home (creado con echo).
- Fichero saludar.txt en $HOME/Documentos (creado con el primer cp).
- Fichero nuevo saludo.txt en nuestro home (creado con el segundo cp).

!!! Nota
    Recuerda que el caracter "." representa el directorio actual y el ".." el anterior. Por tanto el "./" de estos ejemplos podría omitirse y funcionaría igualmente, pero tenemos que entenderlo porque es necesario usarlo en ocasiones más adelante.

#### Movimiento y renombrado
Para **mover ficheros** se usa **el comando mv** (**m**o**v**e o mover).
```bash
  # Movemos el fichero fich 1.txt a una nueva carpeta en /home/<usuario>/Documentos/misArchivos/textos
  ## 1. Nos situamos en nuestro home (podemos usar cd /home/<usuario>, cd ~ o cd $HOME)
  cd ~

  ## 2. Creamos la jerarquía de carpetas necesaria, uso ruta absoluta (si usamos -p podemos hacerlo con un solo comando)
  mkdir -p $HOME/Documentos/misArchivos/textos

  ## 3. TODO: instala el programa tree usando la herramienta APT y úsalo pasándole la carpeta de "Documentos".
  ## El comando tree nos permitirá ver la estructura en forma de árbol.
  ...

  ## 4. Muevo (usando ahora ruta relativa) el fichero fich 1.txt a la nueva carpeta
  mv ~/fich \1.txt Documentos\misArchivos\textos

  ## 5. TODO: mueve ahora fich 2.txt a la misma carpeta pero llamándole: fich 2 copia.txt.
  ## Usa solo rutas relativas y REFERENCIANDO LA CARPETA ACTUAL
  ...
```

##### Ejercicio
- Crea una carpeta nueva en tu home llamada "nueva" e intenta mover "misArchivos" ahí con los comandos que hemos visto, ¿funciona?
- Intenta copiarla con cp, ¿funciona?
- Intenta eliminarla con rm y rmdir, ¿funciona?

#### Mover, copiar y eliminar carpetas enteras
Pues no funciona. Si queremos copiar, eliminar o mover carpetas con contenido tenemos que indicarle que queremos que lo haga de forma **recursiva**.

##### Ejercicio
- Busca en el manual como hacer de forma recursiva un copiado de la carpeta misArchivos a una carpeta "copias-seguridad" en tu home. Inténtalo.
- Vamos a mover la carpeta original y quedarnos con la copia. Mueve la carpeta situada en $HOME/Documentos/misArchivos a tu home.
- Finalmente, vamos a borrarla. Borra la carpeta misArchivos de tu home (nos quedamos solo con la copia de seguridad).



TODO: Más comandos:

- wc
- nl
- tac
- hashes (definición y creación)
- Navegación historial de comandos
- Aliases y variables de entorno
-


## Referencias
- Cat Command in Linux/Unix with Examples. Obtenido de: [javatpoint](https://www.javatpoint.com/linux-cat) el 15/01/2024.
- 12 Critical Linux Log Files You Must be Monitoring. Obtenido de [Eurovps blog](https://www.eurovps.com/blog/important-linux-log-files-you-must-be-monitoring/) el 15/01/2024.
