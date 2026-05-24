#! /bin/bash

# Installing mysql and nginx and anyother using functions, coz if we place the repetetive steps in a function, code will be reduced.
# Just calling the function is enough.

user_id=$(id -u)

if [ $user_id -ne 0 ]; then

   echo " You are not root user "
   exit 1
fi

else
   dnf list installed mysql -y
   if [$? -eq 0 ]; then
      echo " mysql is already installed "
      exit 1
      else 
      dnf install mysql -y
      if [ $? -eq 0]; then
         echo " mySQL installation is successful "
         else
         echo " mySQL installation is failed "
      fi
   fi

