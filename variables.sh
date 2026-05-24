#! /bin/bash

#Variables
#~~~~~~~~~~~~

# man1=$1
# man2=$2
# man3=$3
# place=Iran

# echo "$man1 : Lets play a game, whoever blasts $place first, gets kohinor daiamond from UK"
# echo "$man2 : Haha, matter of seconds for me"
# echo "$man3  : which $place ? "
# echo "$man3 rocks"
# echo "$man1 and $man2 shocks"

#Hidden Input
#~~~~~~~~~~~~~~~~~

#  echo "Please enter username"
#  read -s USER_NAME
#  echo "Please enter your password"
#  read -s Password
#  echo "your creds are $USER_NAME and $Password"

#Dynamic Arguments
#~~~~~~~~~~~~~~~~~~~~~

# ts_start=$(date +%s)
# sleep 3
# ts_end=$(date +%s)
# run_time=$((ts_end-ts_start))
# echo "$run_time"

#Special Variables
#~~~~~~~~~~~~~~~~~~~

# echo "$@"
# echo "$#"
# echo "$1"
# echo "$0"
# echo "$USER"
# echo "$PWD"
# echo "$HOME"
# echo "$$"
# echo "$LINENO"
# echo "$SECONDS"
# echo "$RANDOM"
# echo "$?"

#Datatypes
#~~~~~~~~~~~~

# NUM1=10
# NUM2=20
# SUM=$((NUM1+NUM2))
# echo "$SUM"

#Arrays
#~~~~~~~~~~

MOVIES=("RRR" "VARANASI" "PUSHPA")
echo "${MOVIES[@]}"
echo "${MOVIES[0]}"
echo "${MOVIES[1]}"
echo "${MOVIES[2]}"
