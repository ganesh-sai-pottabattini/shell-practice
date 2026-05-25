#! /bin/bash

# for i in {1..10}
# do
# 	echo " $i "
# done

#script.sh mysql nginx mongodb redis etc ....

#LOGS directory location
LOG_DIR=/var/log/shell-script
#LOG file location
LOG_FILE=$LOG_DIR/$0.log
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
R=" \e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"



#Take user id
USER_ID=$(id -u)

VALIDATE()
{
	dnf list installed $package &>> $LOG_FILE
	if [ $? -eq 0 ]; then
		echo -e " $TIMESTAMP [Info] : $Y  Already $package is installed " | tee -a $LOG_FILE
		else
		dnf install $package -y &>> $LOG_FILE
		if [ $? -eq 0 ]; then
			echo "$TIMESTAMP [Success] : "$G" $package is successfully installed " | tee -a $LOG_FILE
			else
				echo "TIMESTAMP [ ERROR ] : $R $package installation has failed " | tee -a $LOG_FILE
		fi
	fi
}

#Confirm user id
if [ $USER_ID -ne 0 ]; then
	echo "$R Please run the script as root user" | tee -a $LOG_FILE
	exit 1
	else
		for package in "$@"
		do
			VALIDATE #"$package"
		done
fi

# sudo user ? 
# no - error, exit

# yes - 
# take 1st arg from the input 
# list
# already exist ?
# yes - exit
# no-
# install 
# success ?
# yes - say successfully installed
# no - say failed 