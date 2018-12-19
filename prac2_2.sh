#!/bin/bash
if [ $# -ne 3 ]
	then
		echo "Us : $0 <parametre 1> <parametre 2> <parametre 3>"
		exit 1
fi
echo "El tercer parametre de l'script de nom $0 es: $3."
echo "Tots els parametres son: $*."