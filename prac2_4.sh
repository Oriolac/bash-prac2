#!/bin/bash
# -----------------------------------------------------------------
# PRA2 : Guions bash
# Codi font: prac2_4.sh
# 
# Oriol Alàs Cercós
# Marta Albets Mitjaneta
# -----------------------------------------------------------------

function mirarConnexió    #agafem el fitxer "who.txt", que és on hi tenim tots els noms dels qui estàn connectats en aquell moment determinat
{
	ps -ef | cut -d " " -f1 > who.txt # De tots els processos actuals agafa l'usuari.
	trobat=0 #L'utilitzarem per no repetir usuaris en cas que no es treguin repetits i dir saber si està connectat o no al marxar del bucl.
	while read nomwho resto #Va llegint tots els usuaris connectats
	do
		if test $1 = $nomwho -a $trobat -eq 0          #entrem al if si coincideix el nom que teniem al fitxer inicial amb un dels que tenim a who.txt
		then
			numProcessos=$(ps -U $1 | wc -l) # Agafem els nombre de processos d'aquell usuari i contem quants en té.
			let numProcessos+=-1 # Li hem de restar un perquè el primer de tots és la capçalera.
			echo "$1 està connectat amb $numProcessos processos en execució"   #si és així entrem i mostrem que aquest usuari està connectat i el nombre de processos que té en execució
			trobat=1
		fi
	done <who.txt
	if [ $trobat -eq 0 ]      #si l'usuari no es troba al fitxer who.txt vol dir que no està connectat
	then
		echo "$1 no està connectat."  #mostrem el missatge
	fi
	rm who.txt
}

function mostrar
{
	IFS=": "
	while read nom resto   #llegim tots els noms que tenim al fitxer i per cadascun entrem a la funció "mirarConnexió, per saber si està connectat o no i, per tant, si l'hem de mostrar"
	do
		mirarConnexió $nom
	done </etc/passwd
}

function mirarParametres
{
	while [ $# -ne 0 ]   
	do
		mirarConnexió $1    #de cadascun dels paràmetres en mirem la connexió i mostrarem per pantalla el missatge corresponent.
		shift           #utilitzarem el shift per anar passant al següent paràmetre
	done
}

case $# in         #cas en el qual non ens passen res com a paràmetre
	0 ) mostrar    #anem a la funcio mostrar i ja hem acabat
		exit 0
		;;
esac
mirarParametres $*    #si s'han passat paràmetres anem a la funció mirarParametres
exit 0