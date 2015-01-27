#!/bin/bash

# Find the real home directory root path.
REAL_HOME_DIR_ROOT=$(/usr/bin/readlink /Users)

# Check that $REAL_HOME_DIR_ROOT is valid.
if [[ "$?" -ne 0 ]]
then

	echo "Error: /Users is not a symbolic link!"
	exit 1

fi

# Get a list of all standard user accounts.
USERNAMES=$(/usr/bin/dscl /Local/Default -list /Users uid | awk '$2 >= 501 {print $1;}')

for USERNAME in $USERNAMES
do

	# Get the user's current NFSHomeDirectory.
	CURRENT_HOME_DIR=$(/usr/bin/dscl /Local/Default -read "/Users/${USERNAME}" NFSHomeDirectory | awk '{print $NF;}')
	
	CORRECT_HOME_DIR="${REAL_HOME_DIR_ROOT}/${USERNAME}"

	# If the user's current home directory does not match the real home directory path.
	if [[ ! "$CURRENT_HOME_DIR" == "$CORRECT_HOME_DIR" ]]
	then

		# Update the home directory path.
		echo "Updating $USERNAME from $CURRENT_HOME_DIR to $CORRECT_HOME_DIR"
		/usr/bin/dscl /Local/Default -change "/Users/${USERNAME}" NFSHomeDirectory "$CURRENT_HOME_DIR" "$CORRECT_HOME_DIR"

	fi

done

exit 0
