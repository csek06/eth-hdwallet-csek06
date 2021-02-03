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
	DIR= "/config"
	if [ $TYPE = "SEED" ]; then
		SCRIPT_FILE= "$DIR/mongo-seed-creator.py"
	fi
	if [ $TYPE = "ADDRESS" ]; then
		SCRIPT_FILE= "$DIR/mongo-address-lookup.py"
	fi
	if [ $TYPE = "BALANCE" ]; then
		SCRIPT_FILE= "$DIR/mongo-balance-lookup.py"
	fi
	if [ -f $SCRIPT_FILE ]; then
		python $SCRIPT_FILE
	else
		echo "Script file not found... $SCRIPT_FILE"
	fi
fi