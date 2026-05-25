#! /bin/bash

# set -e
# trap 'echo "error at $LINENO , command : $BASH_COMMAND"' ERR
# echo " Hello World "
# dfghjklvbnm
# echo " Continueing "

# sudo mkdir /var/log/shell-script
# sudo chown -R ec2-user:ec2-user /var/log/shell-script
# sudo chmod 755 -R /var/log/shell-script

LOG_DIR=/var/log/shell-script
LOG_FILE=$LOG_DIR/$0.log

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
R=" \e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo -e " $TIMESTAMP [ ERROR ] $Y Please run the script as root user " | tee -a $LOG_FILE
    exit 1
fi

VALIDATE()
{
    if [ $1 -ne 0 ]; then
    echo -e "$TIMESTAMP [ERROR] $2 is Failed" | tee -a $LOG_FILE
    exit 1
    else
    echo -e "$TIMESTAMP [INFO] $2 is Successfull" | tee -a $LOG_FILE
    fi
}

cat <<EOF | sudo tee /etc/yum.repos.d/mongo.repo
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/
enabled=1
gpgcheck=0
EOF

VALIDATE $? "Repo File Content Addition "

systemctl enable --now mongod
VALIDATE $? "Starting and Enabling of mongoDB"

