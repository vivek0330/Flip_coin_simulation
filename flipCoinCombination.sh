#!/bin/bash -x

echo "Welcome"

#VARIABLE INITIALIZED
numberOfTimesHead=0
numberOfTimesTail=0

#TAKE USER INPUT
read -p "Enter the limit of number of times coin flips:" limit

#STORE VALUES IN THE DICTIONARY
declare -A dict 
for((i=1; i<=limit; i++))
do
	if [ $(( RANDOM%2 )) -eq 1 ]
	then
		dict[$i]=H
		(( numberOfTimesHead++ ))
	else
		dict[$i]=T
		(( numberOfTimesTail++ ))
	fi
done

#DISPLAY VALUES IN THE DICTIONARY
echo "values in the dictionary : ${dict[@]}"

#CALCULATE PERCENTAGE OF HEAD AND TAIL
headPercent=`awk 'BEGIN{printf("%0.2f" ,('$numberOfTimesHead'*100) / '$limit')}'`
tailPercent=`awk 'BEGIN{printf("%0.2f" ,('$numberOfTimesTail'*100) / '$limit')}'`

#DISPLAY PERCENTAGE OF HEAD AND TAIL
echo "head percent = $headPercent %"
echo "tail percent = $tailPercent %"
