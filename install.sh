#!/usr/bin/env bash

if [[ $(id -u) -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1
fi
if [[ ! type wget ]]; then
	echo "Please install the wget package"
	exit 1
fi
if [[ ! type unzip ]]; then
	echo "Please install the unzip package"
	exit 1
fi
if [[ ! -d /opt/aacs-updater ]]; then
	mkdir -p /opt/aacs_updater
fi
cp aacs-updater.sh /opt/aacs_updater
cp aacs-update.service /etc/systemd/system/
cp aacs-update.timer /etc/systemd/system/

systemctl enable aacs-update.timer
systemctl start aacs-update.service
