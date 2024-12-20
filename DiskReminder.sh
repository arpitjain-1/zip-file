#!/bin/bash

# This fetches the available storage from the Mem column and $7 means the 7th column from the MEm's row
# This converts the storage info byte from GB
CURRENT_STORAGE=$(free --giga | awk '/^Mem/ {print $7}' | tr -d '[:alpha:]')
BOUNDRY=1

if [[ "$CURRENT_STORAGE" -lt "$BOUNDRY" ]] 
then 
	echo "Your devise is running out of the memory"
else
	echo "Your Devise has suffiecient memory"
fi
