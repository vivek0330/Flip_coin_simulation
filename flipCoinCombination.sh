#!/bin/bash -x

echo "Flip coin simulation problem" 

#INITIALIZE THE RANDOM VALUE
random=$(( RANDOM%2 ))

#CHECK THE CONDITION AND DISPLAY HEAD OR TAIL
if [ $random -eq 1 ]
then
	echo "head"
else
	echo "tail"
fi
