#! /bin/bash


echo " Hello Ganesh "
num1=$1
#num2=$2

echo " sum is $((num1 + num2))"

if [ $((num1 % 2)) -eq 0 ]; then
echo " $num1 is even "
else
echo " $num1 is odd "
fi
