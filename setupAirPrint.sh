#!/bin/bash

USERNAME="piuser"
SYSTEMUPDATE="yes" # only "yes" updates the system

if [ $SYSTEMUPDATE == "yes" ]; then
    echo "Updating system"
    sudo apt update
    sudo apt full-upgrade
fi

echo "Installing CUPS"
sudo apt install cups

echo "Configuring CUPS"
echo "Enable network admin access"
sudo cupsctl --remote-admin

echo "Enable printer network sharing"
sudo cupsctl --share-printers

echo "Enable printing from any device"
sudo cupsctl --remote-any

echo "Add user to lpadmin group"
sudo usermod -aG lpadmin "${USERNAME}"

echo "Restarting CUPS"
sudo systemctl restart cups

echo "Configure printer at https://raspberrypi:631"
echo "--> Add printer"
echo "Search for PDD-File of printer model"