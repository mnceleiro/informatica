#!/bin/bash

# Programa ao que se lle pasa como parametro una idade:
## - Se a idade e igual ou superior a 18 anos, escribe: "É maior de idade."
## - Se a idade e inferior a 18 anos, escribe: "É menor de idade."

# Si 	parametro1 	e maior que 	17
# if	$1		greater than	17
# then/entonces
# ...

if [ "$1" -gt 17 ]
then
	echo "E maior de idade."
else
	echo "E menor de idade."
fi
