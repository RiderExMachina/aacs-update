#!/bin/bash

wget "http://fvonline-db.bplaced.net/fv_download.php?lang=eng" -O /tmp/aacs.zip
unzip /tmp/aacs.zip

for USER in $(ls /home); do
	if -d [/home/$USER/.config/aacs]
		cp /tmp/KEYDB.cfg /home/$USER/.config/aacs/
		chown $USER:$USER /home/$USER/.config/aacs/*
	fi
done
