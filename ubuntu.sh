#!/bin/bash

# Configurations you have to set

DESKTOP_DIR="/home/e34/desktop"

# Just printing out "Forensic Questions"	
echo -e "\033[34m\
#######################\n\
# Foreninc Questions #\n\
#######################\
\033[0m"
 
# Waiting for forensic question 1 to be completed
echo -e "\033[33m\n\
Complete forensic question 1 and enter \"done\" when you have gained the points\n\
(Don't stop/exit this script)\n\
\033[0m"

while [ "$QUESTION1STATUS" != 'done' ] 
do
        echo -e "Waiting for you to enter \"done\"..."
        read 'QUESTION1STATUS'
done

# Waiting for forensic question 2 to be completed
echo -e "\033[33m\n\
Now complete forensic question 2 and enter \"done\" when you have gained the points\n\
(Don't stop/exit this script)\n\
\033[0m"

while [ "$QUESTION2STATUS" != 'done' ]
do
	echo -e "Waiting for you to enter \"done\"..."
        read 'QUESTION2STATUS'
done
echo -e ""

echo -e "\033[34m\
###############\n\
# APT Updates #\n\
###############\
\033[0m"

echo -e "\033[33m\n\
Would you like to run APT updates?\033[0m\n\
You will enable security patches and other recommended updates by Canonical."

echo -en "(Y/N)?:"
while :
do
	if [[ "$GETUPDATES" == 'Y' || "$GETUPDATES" == 'y' ]]; then
		echo -e "\n\033[32m\
The APT sources list will now be opened.\n\
Uncomment lines that contain \"security.ubuntu.com\" AND start with \"deb\" (not \"src-deb\").\n\
\033[0m\n\
Press any key to continue..."
		read -n 1
		sudo editor /etc/apt/sources.list
		sudo apt update
		sudo apt upgrade -y
		break
	elif [[ "$GETUPDATES" == 'N' || "$GETUPDATES" == 'n' ]]; then
		echo -e "Skipping updates...\n"
		break
	else
		echo -en "Enter \"Y\" or \"N\":"
		read 'GETUPDATES'

	fi
done
