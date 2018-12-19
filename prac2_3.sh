#!/bin/bash
# -----------------------------------------------------------------
# PRA2 : Guions bash
# Codi font: <nom_guio>
# 
# Oriol Àlàs Cercós
# Marta Albets Mitjaneta
# -----------------------------------------------------------------

function Maxim      #si la opció a triar ha estat maxim, entrem en aquesta funció
{
	major=$1        #inicialitzem aquesta variable amb el primer paràmetre que ens han passat
	while [ $# -ne 0 ]    #mentre no haguem recorregut tots els nombres que ens han passat com a paràmetre anirem entrant al while
	do
		if [ "$1" -ge "$major" ]      #si el valor del paràmetre que llegim en aquell moment, és més gran que el que tenim guardat a la variable "major", entrem al if
		then
			major=$1       #la variable major ara serà igual al paràmetre legit en aquell moment, en cas que entri al if
		fi         #fi del if
		shift       #passm al següent paràmetre i repetim el procés anterior
	done           #fi del while
	return $major      #quan hem acabat de llegir tots els paràmetres, mostrarem el paràmetre que hi ha guardat a la variable major i, que contindrà el valor més gran de tots els paràmetres passats.
}       #fi de la funció màxim

function Minim       #si la opció a triar ha estat mínim, entrem en aquesta funció
{
	minim=$1           #inicialitzem aqeusta variable amb el primer paràmetre que en han passat
	while [ $# -ne 0 ]    #mentre no haguem recorregut tots els paràmetres que ens han passat anirem entrant al while
	do      
		if [ "$1" -le "$minim" ]      #si el valor del paràmetre que llegim en aquell moment, és més petit que el que tenim guardat a la variable "menor", entrem al if
		then
			minim=$1      #la variable menor serà igual al paràmetre llegit en aquell moment, en cas que entri al if
		fi       #fi del if
		shift      #passem al següent paràmetre i repetim el procés anetrior
	done           #fi del while
	return $minim          #quan hem acabat de llegir tots els paràmetres, mostrarem el paràmetre que hi ha guardat a la variable menor i, que contindrà el valor més petit de tots els aràmetres passats
}        #fi de la funció mínim

function Primers      #si la opció ha triar ha estat primers, entrem en aqusta funció
{
	echo -n "Els nombres primers són: "
	while [ $# -ne 0 ]     #mentre no haguem recorregut tots els paràmetres que ens han passat anirem entrant al while
	do
		esPrimer $*   #anem a la funció esPrimer
		let num=$?    #a num hi posarem el valor que ens ha retornat la funció esPrimer
		if [ $num -ne 0 ]    #si num no és 0 llavors printarem aquest valor, sinó res
		then
			echo -n "$num "    
		fi    #fi del if
		shift   #passem al següent valor
	done   #fi deñ while
	echo ""
}

function esPrimer()   #inici de la funció esPrimer
{
	if [ $1 -le 0 ] #si el nombre passat és més petit o igual a 0, la funció retorna un 0
	then
		return 0
	fi
	for((i=$1-1 ; i > 1; i--)) #sino entrem en un bucle for pel qual farà lo següent desde el valor del nombre menys 1 fins a 1
	do
		let res=$1%$i     #a la variable res hi posarem el resultat del residu entre el paràmetre actual i el nombre corresponent al for
		if [ $res = 0 ]   #si el valor de la variable res és 0, vol dir que és una divisió exacta i retornm 0
		then
			return 0
		fi   #fi del if
	done   #fi del while
	return $1   #si no ha retornat un 0 retornarà el nombre en qüestió
}

if [ $# -lt 2 ]    #si el nombre de paràmetres és menor a dos, se'ns mostrarà un missatge perquè s'han de passar mínim dos paràmetres.
	then
		echo "Us : $0 <numero 1> <numero 2> [... <numero N>]"
		exit 1
fi

echo -e "\nM E N U"      #si no es així mostrarem el següent menú 
echo -e "-------\n"
echo "X: maXim"   
echo "N: miNim"
echo -e "P: Primers\n"
echo -n "Tria una opció: "
read opcio
case "$opcio" in
	x|X) Maxim $*     #si cliquem la "x" cridarem a la funció màxim 
		echo "Màxim entre $* és: $?"
		;;
	n|N) Minim $*     #si cliquem la "n" cridarem a la funció mínim
		echo "Mínim entre $* és: $?"
		;;
	p|P) Primers $*    #si cliquem la "p" cridarem a la fúnció primers
		;;
	*) echo "Opció incorrecta"   #si cliquem wualsevol altra tecla mostrarem el missatge d'opció incorrecta
		;;
esac        #tanquem el case
