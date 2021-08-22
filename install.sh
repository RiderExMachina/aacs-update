#!/usr/bin/env bash

if [[ $(id -u) -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1
fi
cp aacs-updater.sh /opt/
cp aacs-update.service /etc/systemd/system/
cp aacs-update.timer /etc/systemd/system/
