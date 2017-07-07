#!/bin/bash
DELAY="${1:-3}"

function produce {
	echo "$1,$2,$3" 
}

timestamp=1499420000

while :
do
	
	sensor=$(( ( RANDOM % 10 )  + 1 ))
	temp=$(( ( RANDOM % 20 )  + 30 ))

	produce $sensor $temp $timestamp 
	
	sleep $DELAY
	timestamp=$(( $timestamp + 10 ))

done