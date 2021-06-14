#!/bin/bash -x 

echo "Welcome"

#CONSTANT INITIALIZED
NUMBER_OF_COINS=2

#TAKE USER INPUT
read -p "Enter the limit of number of times coin flips:" limit

#STORE VALUES AND INDEX IN THE DICTIONARY
declare -A dict 
for((i=1; i<=limit; i++))
do
	for((j=1; j<=NUMBER_OF_COINS; j++))
	do
		random=$(( RANDOM%2 ))
		if [ $random -eq 1 ]
		then
			sideOfCoin+=H
		else
			sideOfCoin+=T
		fi
	done
	(( dict[$sideOfCoin]++ ))
	sideOfCoin=""
done

#DISPLAY VALUES AND INDEX IN THE DICTIONARY
echo "values in the dictionary : ${dict[@]}"
echo "indexes in the dictionary : ${!dict[@]}"

#DISPLAY PERCENTAGE OF COMBINATIONS IN DICTIONARY
echo "Percentage of head-tail combinations in the dictionary :"
for key in ${!dict[@]}
do
	percentage=`awk 'BEGIN{printf("%0.2f" ,('${dict[$key]}'*100) / '$limit')}'`
	echo $percentage
done
