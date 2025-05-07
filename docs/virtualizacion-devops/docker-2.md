# Docker: parte II

## Crear repositorios de imágenes en Dockerhub
Vamos a ver algunos pequeños comandos adicionales sobre imágenes:
```
docker image inspect mysql
docker image history mysql
```

El primer comando (`inspect`) ya lo habíamos visto, aunque no lo hemos probado sobre imágenes (sí sobre contenedores y redes). El segundo comando muestra el historial de versiones de la imagen.

!!! Note "Tarea"
    Regístrate en dockerhub.

Para construir una imagen a partir de otra existente podemos usar docker tag, lo que añadirá nuevas capas a partir de las ya existentes. Vamos a construir nuestra propia imagen de Apache2 con `docker image tag`:
```
# Exploramos primero la ayuda
docker image tag --help

docker image tag ubuntu/apache2 tu_usuario_dockerhub/mi-apache2
```

Si el comando te da error `No such image`, quizás tengas que descargarla primero, ¿recuerdas el comando para descargar una imagen?

Si miras la lista de imágenes con `docker image ls`, verás que la imagen de ubuntu/apache2 y la de tu_usuario/mi-apache2 tienen el mismo id, ya que realmente son la misma y no ha cambiado.

Ahora, vamos a subir la imagen a nuestro repositorio de Dockerhub:
```
docker image push <tu_usuario>/mi-apache2
```

Es posible que esto no te funcione, ya que no te has logeado en Dockerhub. Vamos a identificarnos:
```
docker login  # Sigue los pasos
```

!!! tip "Si no te funciona..."
    Si estás en una máquina con interfaz gráfica, se te abrirá un navegador y podrás introducir un código de confirmación, pero si estás en una máquina sin interfaz gráfica (p. ej: una máquina en AWS) y has creado la cuenta con Google u otro servicio, esto no funcionará. En este caso tendrás que ir a la configuración de tu perfil de Dockerhub y crear un token de autenticación.

Bien, ahora que estamos logeados, vamos a intentar de nuevo subir la imagen:
```bash
docker image push <tu_usuario>/mi-apache2
```

!!! Ejercicio
    1. Haz todo lo anterior y luego verifica en tu perfil de Dockerhub que se ha creado el repositorio correspondiente.
    2. Ahora, **a partir del repositorio que has creado**, añade un tag a la imagen (como nginx**:1.27.5** o nginx**:latest**). Puedes probar por ejemplo con mi-apache2:pruebas. Tendrás que usar los mismos comandos que anteriormente, pero ahora partiendo ya de la imagen que tienes ya subida en lugar de la oficial de Apache2.

Vamos a resolver el ejercicio:
```bash
docker image tag <usuario>/apache2 <usuario>/apache2:pruebas

# Miramos que el TAG de la imagen aparezca
docker image ls

# Subimos la capa nueva
docker image push <usuario>/apache2:pruebas
``` 

Para construir una imagen a partir de otra existente usamos el comando `docker image build`. Como siempre, vamos a empezar viendo la ayuda:
```bash
docker image build --help
```

## Dockerfiles
Se pueden realizar configuraciones de Docker desde ficheros que tengan exactamente de nombre: **Dockerfile**. Un Dockerfile básico tiene la siguiente nomenclatura:

```bash
FROM <imagen>

EXPOSE <puerto>
```

Consulta la documentación oficial en [Writing a Dockerfile](https://docs.docker.com/get-started/docker-concepts/building-images/writing-a-dockerfile/).

## Ejercicios
Prepara un fichero .md (markdown) para documentar estos ejercicios en formato tutorial (puedes usar VSCode con el plugin *Markdown all-in-one*). Usa siempre sentencias de código en lugar de imágenes.

1. Crea un contenedor que monte un Wordpress totalmente funcional con base de datos (empieza creando el Wordpress y luego vas viendo).
2. Cuando consigas completar el Wordpress, haz que los datos no se pierdan cuando eliminas los contenedores (usando un volumen).
3. Exporta el script de base de datos de la máquina y guárdalo.
4. Finalmente, crea un Dockerfile y haz que ese script se ejecute en el arranque de Wordpress (RUN). De esta manera tendremos un Wordpress completo y totalmente configurado.
5. Haz lo mismo con Drupal versión 9.
6. Sube ambas imágenes a tu repositorio en Dockerhub y añade un README en Dockerhub con los comandos que has utilizado.
7. Finalmente, edita el repositorio en Dockerhub y en "overview" pega tu documentación.
8. Sube el link de dockerhub de las imágenes al aula virtual.