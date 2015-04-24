#!/bin/bash

###########################################################################
# Fonction print permettant l'affichage de façon aleatoire des index du tableaux
# On notera la subtilite,cad le roulement des caractères
printLikeACrazyPrinter(){
	HERELINE=$1 ; HERECOL=$2
	while [ $CPT -lt $MAXLINES ] # On boucle tant que la chaine n'arrive pas a la fin du term
	do
		x=$(($RANDOM%30))
		y=0
		while [ $y -lt $x ]
		do
			((y++))
			I=$(($RANDOM % $NBI))
			tput cup $HERELINE $HERECOL
			if [[ $BOLD -eq 1 ]] && [[ $(( $RANDOM % 3 )) -gt "0" ]]; then
				echo -e -n "$COLOR" "$GROSGRAS" "${TAB[$I]}"
			else
				echo -e -n "$COLOR" "${TAB[$I]}"
			fi
		done
		((HERELINE++))
		((CPT++))
	done
	eraseThisFuckingString $HERELINE $HERECOL &
}

###########################################################################
# Fonction erase pour effacer la chaine produite et créer un effet chenille
eraseThisFuckingString(){
	#sleep $(( $RANDOM % 5 ))
	FIN=$(tput lines)
	LL=$1 ; CC=$2
	tput cup $LL $CC
	echo -n "                    "
	((LL++))
	sleep $(( $RANDOM % 10 ))
	while [[ $i -ne $FIN ]]; do
		echo -n "             "
		((i++))
	done
}

###########################################################################
# Fonction pour les noobs
helpMeIamANoob(){
	echo "Usage: $0 [options]"
	echo '-C [color]: Use this color for matrix (default green) / red, blue,white,cyan'
	echo '-b: Bold characters on'
	echo '-h or -?: Print usage and exit'
	exit 0
}




#######################################################
#######################################################
############################ MAIN #####################
#######################################################
#######################################################


# Declaration du tableau avec alphanum+symboles
TAB=(a b c d e f g h i j T H E G A M E k l m n o p q r s t u v w x y z
B C D F H I J K L N O P Q R S T U V W X Y Z
0 1 2 3 4 5 6 7 8 9
'!' '@' '$' '%' '^' '&' '#' '*' '(' ')' '+' '-' '=' '|' '/' '<' '>' '~' '`' ':' ';' '[' ']' '{' '}' '|' ',' '.' '?' '_')

# Nombre d'index
NBI=${#TAB[*]}

# Couleur par defaut / Gras (bold on)
COLOR="\\033[1;32m"
GROSGRAS="\033[0m"

CPT=0

line_num=$(( max_lines / 2 ))

# Nombre max de colonne dans le terminal actuel
MAXCOLS=$(tput cols)
MAXLINES=$(tput lines)

# Nombre d'argument
NBARG=$# ; OSEF=0

# Le choix des colonnes se fait de facon RANDOM
COL=$(( $RANDOM % $(tput cols) ))

# On commence par le haut du term, c'est plus swag
LINE=0

# On trap les signaux (SIGKILL, etc) et on kill tous les process du cmatrix même les backgrounded
KILL='ps aux |grep "/bin/bash ./cmatrix" | tr -s "\t" " " |cut -d" " -f2 |xargs kill -9'
trap "eval $KILL ; reset " 1 2 3 9

if (( $NBARG != 0 )); then
	while (( $NBARG != $OSEF )); do
		ARG=$1
		case "$ARG" in
			"-C")
				ARG2=$2
				case "$ARG2" in
					"red")
						COLOR="\\033[0;31m" ;;
					"blue")
						COLOR="\\033[1;34m" ;;
					"white")
						COLOR="\\033[0m" ;;
					"cyan")
						COLOR="\\033[1;36m" ;;
				esac
				;;
			"-b")
				BOLD="1" ;;
			"-h" | "-?")
				helpMeIamANoob ;;
			"-V")
				echo -e "Cmatrix bash, version 1.0 by Notfound\nNB: The game"
				exit 0
		esac
		shift
		$((OSEF++))
	done
fi

clear

while true; do
	# Le choix des colonnes se fait de facon RANDOM
	COL=$(( $RANDOM % $(tput cols) ))

	# On commence par le haut du term, c'est plus swag
	LINE=0

	# Fuck les commentaires srsly
	GO=$( echo $(( $RANDOM % 300)) )

	if [[ "$GO" -le "1" ]]; then
		sleep $(( $RANDOM % 1))
		printLikeACrazyPrinter $LINE $COL &
		#eraseThisFuckingString $LINE $COL &
	fi
done
tput cup $max_lines 0
exit 0
