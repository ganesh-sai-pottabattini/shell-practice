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
else 
echo " I am continuing "
fi