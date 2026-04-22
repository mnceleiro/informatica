#!/bin/bash

# Programa interactivo que pida informacion al usuario para crear o eliminar usuarios del sistema

# Pide al usuario el nombre usuario que quiere crear
echo "¿Cal é o nome que queres para o teu usuario?"
read nome

# Creamos o usuario e indicamos que se fixo con exito
sudo useradd -m -d /home/$nome -s /bin/bash $nome
echo "O usuario $nome creouse con éxito."
