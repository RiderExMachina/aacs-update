#!/usr/bin/env bash

if [[ $(id -u) -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1
fi
cp aacs-updater.sh /opt/
cp aacs-update.service /etc/systemd/system/
cp aacs-update.timer /etc/systemd/system/

systemctl enable aacs-update.service
systemctl start aacs-update.service

if [[!$ -ne 0]]; then
	echo "Something went wrong. Please create a pull request with the information from 'systemctl status aacs-update'"
fi
