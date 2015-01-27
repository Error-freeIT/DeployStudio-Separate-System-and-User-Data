#!/bin/bash

# Partitions to look for
PARTITIONS=( "System" "Data" )

for PARTITION in "${PARTITIONS[@]}"
do

	STATUS=$(/usr/sbin/diskutil list "$PARTITION")
		
	if [[ ! "$STATUS" == "Could not find disk"* ]]
	then
		FOUND=$((FOUND+1))
	fi

done


if [[ "${#PARTITIONS[@]}" -eq "$FOUND" ]]
then

	# All required partitions already exist, skip partitioning.  
	echo ""

elif [[ "$FOUND" -eq "" ]]
then

	# None of the listed partitions were found, disk needs partitioning.  
	echo "RuntimeSelectWorkflow: Partition"

else

	# Only some of the required partitions were found, stopping workflow.
	exit 1

fi

exit 0