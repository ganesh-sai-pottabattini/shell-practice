#! /bin/bash

set -e
trap 'echo "error at $LINENO , command : $BASH_COMMAND"' ERR
echo " Hello World "
dfghjklvbnm
echo " Continueing "

sudo mkdir /var/log/shell-script
sudo chown -R ec2-user:ec2-user /var/log/shell-script
sudo chmod 755 -R /var/log/shell-script