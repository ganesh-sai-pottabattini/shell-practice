#! /bin/bash

# Installing mysql and nginx and anyother using functions, coz if we place the repetetive steps in a function, code will be reduced.
# Just calling the function is enough.

# user_id=$(id -u)

# if [ $user_id -ne 0 ]; then

#    echo " You are not root user "
#    exit 1

#    validate()
#    {
#       if [ $2 -eq 0 ]; then
#          echo " $1 installation is successful "
#          else
#          echo " $1 installation is failed "
#       fi
#    }

# else
#    dnf list installed mysql -y
#    if [ $? -eq 0 ]; then
#       echo " mysql is already installed "
#       exit 1
#       else 
#       dnf install mysql -y
#       validate mySQL $?
#    fi
# fi

# User_Id=$(id -u)
# if [ User_Id -ne 0 ]; then
#    echo " need to be run as root user, use sudo "
#    exit 1

#    else
#       dnf list installed mySQL -y
#       if [ $? -eq 0 ]; then
#          echo " already installed "
#          else
#             dnf install mySQL -y
#                if [ $? -eq 0 ]; then
#                   echo " mySQL installation is successful "
#                   else 
#                      echo " mySQL installation is failed "
#                 fi
#        fi
# fi


User_Id=$(id -u)
if [ $User_Id -ne 0 ]; then
   echo " need to be run as root user, use sudo "
   exit 1
   else

	validate mysql
	validate nginx


	validate(){
		dnf list installed $1 -y
		if [ $? -eq 0 ]; then
         		echo " $1 already installed "
			else
            		dnf install $1 -y
               			if [ $? -eq 0 ]; then
                  			echo " $1 installation is successful "
                  			else 
                     			echo " $1 installation is failed "
	                        fi
		fi
	           }
fi