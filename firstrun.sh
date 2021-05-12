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
	DIR="/config"
	if [ $TYPE = "GO_ADDRESS" ]; then
		echo "Running as a Golang Address checker"
		SCRIPT_FILE="$DIR/mongo-go-address-lookup_linux"
		chmod +x $SCRIPT_FILE
		$SCRIPT_FILE
	elif [ $TYPE = "GO_SEED" ]; then
		echo "Running as a Golang Seed creator"
		SCRIPT_FILE="$DIR/mongo-go-seed-creator_linux"
		chmod +x $SCRIPT_FILE
		$SCRIPT_FILE
	else
		if [ $TYPE = "SEED" ]; then
			echo "Running as a seed creator"
			SCRIPT_FILE="$DIR/mongo-seed-creator.py"
		elif [ $TYPE = "ITERATOR" ]; then
			echo "Running as a iterator list creator"
			SCRIPT_FILE="$DIR/mongo-iterator-creator.py"
		elif [ $TYPE = "ADDRESS" ]; then
			echo "Running as an address checker"
			SCRIPT_FILE="$DIR/mongo-address-lookup.py"
		elif [ $TYPE = "BALANCE" ]; then
			echo "Running as a balance checker"
			SCRIPT_FILE="$DIR/mongo-balance-lookup.py"
		elif [ $TYPE = "ETHERSCAN" ]; then
			echo "Running as an etherscan balance checker"
			SCRIPT_FILE="$DIR/mongo-balance-lookup-etherscan.py"
		elif [ $TYPE = "OPENETHEREUM" ]; then
			echo "Running as an openethereum balance checker"
			SCRIPT_FILE="$DIR/mongo-balance-lookup-openethereum.py"
		elif [ $TYPE = "BALANCE_CROSSCHECK" ]; then
			echo "Running as a mongodb balance crosschecker"
			SCRIPT_FILE="$DIR/mongo-balance-crosscheck.py"
		elif [ $TYPE = "WORKER_ADMIN" ]; then
			echo "Running as a mongodb worker admin"
			SCRIPT_FILE="$DIR/mongo-worker-admin.py"
		elif [ $TYPE = "BALANCES_UPDATER" ]; then
			echo "Running as a mongodb balances updater"
			SCRIPT_FILE="$DIR/mongo-bigquery-getbalances.py"
		elif [ -f $SCRIPT_FILE ]; then
			python3 $SCRIPT_FILE
		else
			echo "Script file not found... $SCRIPT_FILE"
		fi
	fi
	
fi