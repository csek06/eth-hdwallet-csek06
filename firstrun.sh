#!/bin/bash

#Get docker env timezone and set system timezone
echo "setting the correct local time"
echo $TZ > /etc/timezone
export DEBCONF_NONINTERACTIVE_SEEN=true DEBIAN_FRONTEND=noninteractive
dpkg-reconfigure tzdata

echo "Setting correct permissions"
chown -R nobody:users /config

echo "Attempting to run script file"
SCRIPT_FILE=/config/script.sh
if [ -f "$SCRIPT_FILE" ]; then
	echo "file found, executing script"
	chmod +x $SCRIPT_FILE
	bash $SCRIPT_FILE
else
	echo "script file not found"
fi
