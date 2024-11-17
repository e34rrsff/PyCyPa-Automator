#!/usr/bin/env bash

echo -e "YOU DO NOT NEED TO RUN THIS SCRIPT IF YOU ALR-\n\
EADY HAVE A VIRTUAL PYTHON ENVIRONMENT SET UP\n"
echo -e "PRESS CTRL-C TO EXIT\n"

echo -e "Setting up your Python virtual environment...\n"
sleep 4

while [[ "$LOCATION_VERIFY" != "y" || "$LOCATION_VERIFY" == "y" ]]
do
		echo -en "Where do you want your Python virtual environment? Empty for default (\$HOME/.python)\n\
Answer: " && read LOCATION

		if [ "$LOCATION" == "" ]; then
				LOCATION="${HOME}/.python"

		elif [ "$LOCATION" != "" ]; then
				LOCATION=$( sed "s,~,/home/`whoami`,g" <<< ${LOCATION} )
		fi

		echo -en "Does this look good? ${LOCATION}\n(Y/N): " && read LOCATION_VERIFY
		echo ""


		if [[ "$LOCATION_VERIFY" == "Y" || "$LOCATION_VERIFY" == "y" ]]; then
				break
		else
				continue
		fi
done

echo -e "Installing python3-venv..."
sleep 1

if [ -x /usr/bin/apt ]; then
		PACKAGE_MANAGER="apt"
elif [ -x /usr/bin/dnf ]; then
		PACKAGE_MANAGER="dnf"
else
		echo -e "ERROR: I dunno what package manager you have."
fi

sudo ${PACKAGE_MANAGER} install python3-venv
echo -e ""

python3 -m venv $LOCATION

echo -e "Updating PATH in ~/.bashrc"
echo -e "PATH=\"$LOCATION/bin:\$PATH\"" >> $HOME/.bashrc
