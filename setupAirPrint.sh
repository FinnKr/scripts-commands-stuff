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

echo "Install driver for Brother hl-5350dn"
wget https://download.brother.com/welcome/dlf006893/linux-brprinter-installer-2.2.3-1.gz
gunzip linux-brprinter-installer-2.2.3-1.gz
sudo su
echo "Model name: hl-5350dn"
echo "Follow the instractions, Device-URI: No"
bash linux-brprinter-installer-2.2.3-1

echo "Configure printer at https://raspberrypi:631"
echo "--> Add printer"
