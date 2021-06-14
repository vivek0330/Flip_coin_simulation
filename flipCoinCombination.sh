#!/bin/bash -x

#CONSTANT
COUNT=10

#FUNCTION FOR FLIPPING COIN
function flipCoin(){
	result=$(( RANDOM%2 ))
	echo $result
}

#FUNCTION FOR CALCULATING PERCENTAGE
function percentage(){
   percent=$(( $1*10 ))
   echo $percent
}

#GENERATING SINGLET AND STORING IN DICTIONARY
IS_HEAD=0
IS_TAIL=1

declare -A results
count=0
results[HEAD]=$count
results[TAIL]=$count

for ((  i=0 ; i<COUNT ; i++ ))
do
	flip=$( flipCoin )
	if [[ flip -eq $IS_HEAD ]]
	then
		(( results[HEAD]++  ))
	elif [[ flip -eq $IS_TAIL ]]
	then
		(( results[TAIL]++ ))
	fi
done

#SINGLET PERCENTTAGE
results[HEAD_Percent]=$( percentage ${results[HEAD]} )
results[TAIL_Percent]=$( percentage ${results[TAIL]} )

#GENERATING DOUBLET AND STORING IN DICITIONARY
IS_HEAD_HEAD="00"
IS_HEAD_TAIL="01"
IS_TAIL_HEAD="10"
IS_TAIL_TAIL="11"

count=0
results[HEAD_HEAD]=$count
results[HEAD_TAIL]=$count
results[TAIL_HEAD]=$count
results[TAIL_TAIL]=$count
for (( i=0 ; i<COUNT ; i++ ))
do
		flip=$( flipCoin )$( flipCoin )
	if [[ flip -eq $IS_HEAD_HEAD ]]
	then
		(( results[HEAD_HEAD]++ ))
	elif [[ flip -eq $IS_HEAD_TAIL ]]
	then
		(( results[HEAD_TAIL]++ ))
	elif [[ flip -eq $IS_TAIL_HEAD ]]
	then
		(( results[TAIL_HEAD]++ ))
	elif [[ flip -eq $IS_TAIL_TAIL ]]
	then
      (( results[TAIL_TAIL]++ ))
	fi
done

#DOUBLET PERCENTAGE
results[HEAD_HEAD_Percent]=$( percentage ${results[HEAD_HEAD]} )
results[HEAD_TAIL_Percent]=$( percentage ${results[HEAD_TAIL]} )
results[TAIL_HEAD_Percent]=$( percentage ${results[TAIL_HEAD]} )
results[TAIL_TAIL_Percent]=$( percentage ${results[TAIL_TAIL]} )

#GENERATING TRIPLET AND STRING IN DICTIONARY
IS_HEAD_HEAD_HEAD="000"
IS_HEAD_HEAD_TAIL="001"
IS_HEAD_TAIL_HEAD="010"
IS_TAIL_HEAD_HEAD="100"
IS_HEAD_TAIL_TAIL="011"
IS_TAIL_HEAD_TAIL="101"
IS_TAIL_TAIL_HEAD="110"
IS_TAIL_TAIL_TAIL="111"

count=0

results[HEAD_HEAD_HEAD]=$count
results[HEAD_HEAD_TAIL]=$count
results[HEAD_TAIL_HEAD]=$count
results[TAIL_HEAD_HEAD]=$count
results[HEAD_TAIL_TAIL]=$count
results[TAIL_HEAD_TAIL]=$count
results[TAIL_TAIL_HEAD]=$count
results[TAIL_TAIL_TAIL]=$count

for (( i=0 ; i<COUNT ; i++ ))
do
	flip=$( flipCoin )$( flipCoin )$( flipCoin )
	if [[ flip -eq $IS_HEAD_HEAD_HEAD ]]
	then
		(( results[HEAD_HEAD_HEAD]++ ))
	elif [[ flip -eq $IS_HEAD_HEAD_TAIL ]]
	then
		(( results[HEAD_HEAD_TAIL]++ ))
	elif [[ flip -eq $IS_HEAD_TAIL_HEAD ]]
	then
		(( results[HEAD_TAIL_HEAD]++ ))
	elif [[ flip -eq $IS_TAIL_HEAD_HEAD ]]
	then
		(( results[TAIL_HEAD_HEAD]++ ))
	elif [[ flip -eq $IS_HEAD_TAIL_TAIL ]]
	then
		(( results[HEAD_TAIL_TAIL]++ ))
	elif [[ flip -eq $IS_TAIL_HEAD_TAIL ]]
	then
		(( results[TAIL_HEAD_TAIL]++ ))
	elif [[ flip -eq $IS_TAIL_TAIL_HEAD ]]
	then
		(( results[TAIL_TAIL_HEAD]++ ))
	elif [[ flip -eq $IS_TAIL_TAIL_TAIL ]]
	then
		(( results[TAIL_TAIL_TAIL]++ ))
	fi
done

#TRIPLET PERCENTAGE
results[HEAD_HEAD_HEAD_Percent]=$( percentage ${results[HEAD_HEAD_HEAD]} )
results[HEAD_HEAD_TAIL_Percent]=$( percentage ${results[HEAD_HEAD_TAIL]} )
results[HEAD_TAIL_HEAD_Percent]=$( percentage ${results[HEAD_TAIL_HEAD]} )
results[TAIL_HEAD_HEAD_Percent]=$( percentage ${results[TAIL_HEAD_HEAD]} )
results[HEAD_TAIL_TAIL_Percent]=$( percentage ${results[HEAD_TAIL_TAIL]} )
results[TAIL_HEAD_TAIL_Percent]=$( percentage ${results[TAIL_HEAD_TAIL]} )
results[TAIL_TAIL_HEAD_Percent]=$( percentage ${results[TAIL_TAIL_HEAD]} )
results[TAIL_TAIL_TAIL_Percent]=$( percentage ${results[TAIL_TAIL_TAIL]} )

#STORING DICTIONARY TO ARRAY
index=0
for i in ${!results[@]}
do
	array[ (( index++ )) ]=${results[$i]}
done

#SORTING ARRAY
length=${#array[@]}
temporary=0
for (( i=0 ; i<$length ; i++ ))
do
	for (( j=0 ; j<$length ; j++ ))
	do
		if [ ${array[i]} -lt ${array[j]} ]
		then
			temporary=${array[i]}
			array[i]=${array[j]}
			array[j]=$temporary
		fi
	done
done

#FINDING WINNING COMBINATION
highestPercent=${array[$length-1]}
for i in ${!results[@]}
do
	if (( ${results[$i]}==$highestPercent ))
	then
		winningCombination=${i::-8}
	fi
done
printf "$winningCombination\n"
