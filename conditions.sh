#! /bin/bash
# num=$1
# if [ $num -gt 10 ]; then
# echo " > "
# elif [ $num -eq 10 ]; then 
# echo "="
# else
# echo " < "
# fi

# If, else, elif, nested if conditions
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# echo " please give the values "
# read num1
# read num2

# # If two even numbers are passed by the user, 

# if [ $((num1 % 2)) -eq 0 ] && [ $((num2 % 2)) -eq 0 ]; then
# echo " addition is : $((num1 + num2)) "
# fi

user_id=$(id -u)

if [ $user_id -ne 0 ]; then
echo " You are not root user "
exit 1
else 
dnf list installed mysql -y
if [ $? -eq 0 ]; then
echo " mySQl is already installed "
else
echo " Installing mySQL "
dnf install mysql -y
if [ $? -ne 0 ]; then
echo " mySQL installation has failed "
exit 1
else
echo " mySQL installation is successful "
fi
fi
fi