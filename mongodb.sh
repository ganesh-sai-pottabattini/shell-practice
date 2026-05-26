#! /bin/bash

LOG_DIR=/var/log/shell-script
#LOG file location
LOG_FILE=$LOG_DIR/$0.log
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


cat <<EOF > /etc/yum.repos.d/mongo.repo &>> $LOG_FILE
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/
enabled=1
gpgcheck=0
EOF

VALIDATE()
{
    if [ $1 -ne 0 ]; then
        echo " $2 is Failed "
        else
        echo " $2 is Successful "
    fi
}

dnf list installed mongodb-org
VALIDATE $? "Listing mongoDB "

dnf install mongodb-org -y &>> $LOG_FILE
VALIDATE $1 " Installing mongodb "

systemctl enable --now mongod
VALIDATE $? "Starting and Enabling of mongoDB"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Allowing all traffic"

systemctl restart mongod
VALIDATE $? "Restarting mongoDB"