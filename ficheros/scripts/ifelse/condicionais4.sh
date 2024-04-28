#!/bin/bash

# Programa ao que se lle pasa como parametro una idade:
## - Se a idade e igual ou superior a 18 anos, escribe: "É maior de idade."
## - Se a idade e inferior a 18 anos, escribe: "É menor de idade."
## - Se a idade e igual ou superior a 67 anos, escribe: "Está xubilado."

# Si 	parametro1 	e maior que 	17
# if	$1		greater than	17
# then/entonces
# ...

if [ $1 -gt 17 ]
then
	if [ $1 -gt 66 ]
	then
		echo "Está xubilado."
	else
		echo "É maior de idade."
	fi
else
	echo "E menor de idade."
fi
