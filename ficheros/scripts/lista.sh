#!/bin/bash

echo "Este programa mostra os ficheiros de /, /bin e da miña carpeta personal de usuario."
echo ""
echo ""
echo "Mostrando os ficheiros do directorio RAIZ..."
ls /

echo ""
echo "Mostrando os ficheiros que hai en /bin..."
ls /bin

echo ""
echo "Mostrando o que hai no meu HOME"
ls ~
echo ""
# Outras solucions:
#	ls /home/marcos
#	ls $HOME
