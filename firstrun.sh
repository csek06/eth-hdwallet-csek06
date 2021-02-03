#!/bin/bash

#Get docker env timezone and set system timezone
echo "setting the correct local time"
echo $TZ > /etc/timezone
export DEBCONF_NONINTERACTIVE_SEEN=true DEBIAN_FRONTEND=noninteractive
dpkg-reconfigure tzdata

echo "Setting correct permissions"
chown -R nobody:users /config

echo "Checking Container Type"
if [ ! -z $TYPE ]; then
	CONFIG_FILE = /config/
	if [[ $TYPE = SEED ]]; then
		CONFIG_FILE = $CONFIG_FILE/mongo-seed-creator.py
	fi
	if [[ $TYPE = ADDRESS ]]; then
		CONFIG_FILE = $CONFIG_FILE/mongo-address-lookup.py
	fi
	if [[ $TYPE = BALANCE ]]; then
		CONFIG_FILE = $CONFIG_FILE/mongo-balance-lookup.py
	fi
	if [ -f $CONFIG_FILE ]; then

	else
		echo "Script file not found... $CONFIG_FILE"
	fi
fi