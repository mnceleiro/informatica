#!/bin/bash

# Programa ao que se lle pasa como parametro una idade:
## - Se a idade e igual ou superior a 18 anos, escribe: "É maior de idade."
## - Se a idade e inferior a 18 anos, escribe: "É menor de idade."
## - Se a idade e igual ou superior a 67 anos, escribe: "Está xubilado."
## - Se non se pasan parámetros. Mostrar un mensaxe indicando como usar o programa.
## - Por exemplo:
## 	- El programa debe usarse coa seguinte sintaxe: ./condicionais6.sh <numero>

# Si 	parametro1 	e maior que 	17
# if	$1		greater than	17
# then/entonces
# ...

# Podríamos poner $# -ne 1, pero utilizamos esto para el ejemplo
if [ $# -eq 0 ] || [ $# -gt 1 ]
then
	echo "O programa debe executarse coa seguinte sintaxe: $0 <numero>"

elif [ "$1" -gt 66 ]
then

	echo "Está xubilado."

elif [ "$1" -gt 17  ]
then
	echo "É maior de idade."

else
	echo "E menor de idade."
fi
