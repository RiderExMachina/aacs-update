#!/bin/bash

LOGFILE="/var/log/aacs-updater.log"


echo "$(date -u) - Starting AACS update" >> $LOGFILE
wget "http://fvonline-db.bplaced.net/fv_download.php?lang=eng" -O /tmp/aacs.zip
unzip /tmp/aacs.zip -d /tmp

for USER in $(ls /home); do
	if [ -d "/home/$USER/.config/aacs" ]; then
		if [ $(getent passwd $USER >/dev/null) ]; then					
			cp /tmp/keydb.cfg "/home/$USER/.config/aacs/KEYDB.cfg"
			chown -R "$USER":"$USER" "/home/$USER/.config/aacs/"
		fi
	fi
done

echo "$(date -u) - Cleaning up" >> $LOGFILE
rm /tmp/aacs.zip /tmp/keydb.cfg
