#!/bin/bash

# Variables you might have to change manually

DESKTOP_DIR="/home/$(whoami)/Desktop"

# Start of Forensic Questions Section
echo -e "\033[34m\
#######################\n\
# Foreninc Questions #\n\
#######################\
\033[0m"

echo -e "\033[33m\n\
Complete forensic question 1 and enter \"done\" when you have gained the points\n\
(Don't stop/exit this script)\n\
\033[0m"

while [ "$QUESTION1STATUS" != 'done' ] 
do
	echo -e "Waiting for you to enter \"done\"..."
    read 'QUESTION1STATUS'
done

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
# End of Forensic Questions Section

# APT Updates Section
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
		# /etc/apt/sources.list contains the URLs pointing to system .deb packages
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
# End of APT Updates Section

echo -e "\033[34m\
###############################\n\
# Removing Unauthorized Files #\n\
###############################\
\033[0m"

echo -e "\033[33m\n\
Check users' home directories for unauthorized files?\
\033[0m\n"

echo -en "(Y/N)?:"
while :
do
	if [[ "$CHECK_UNAUTH_FILES" == 'Y' || "$CHECK_UNAUTH_FILES" == 'y' ]]; then
		echo -e "\n\033[32m\
Give the command several seconds to find the files; then review them.\n\
Press Q when you are done reviewing the files.\n\
\033[0m\n\
Press any key to continue..."
		read -n 1
		export BADFILESLIST = $(sudo find /home \
-iname "*.mp3" -o \
-iname "*.mp4" -o \
-iname "*.mov" -o \
-iname "*.wmv" -o \
-iname "*.avi" -o \
-iname "*.gif" -o \
-iname "*.webm" 2>/dev/null | awk '{ print "\""$0"\""}' )
		echo $BADFILESLIST | sed "s/\" /\n/g" | sed "s/\"//g" | less
		while :
		do
			if [[ "$RM_FILES" == 'Y' || "$RM_FILES" == 'y' ]]; then
				echo -e "Moving unauthorized files to /tmp/unauthorized-files/...'"
				sudo mkdir -m 770 -p /tmp/unauthorized-files/
				sudo cp --parents $BADFILESLIST /tmp/unauthorized-files/
				sudo rm -f $BADFILESLIST
				break
			elif [[ "$RM_FILES" == 'N' || "$RM_FILES" == 'n' ]]; then
				echo -e "Skipped removing unauthorized files...\n"
				break
			else
				echo -e "\n\033[33m\
Would you like to remove the files that were listed?\
\033[0m"
				echo -en "Enter \"Y\" or \"N\":"
				read 'RM_FILES'
			fi
		done
		break
	elif [[ "$CHECK_UNAUTH_FILES" == 'N' || "$CHECK_UNAUTH_FILES" == 'n' ]]; then
		echo -e "Skipping check...\n"
		break
	else
		echo -en "Enter \"Y\" or \"N\":"
		read 'CHECK_UNAUTH_FILES'

	fi
done
