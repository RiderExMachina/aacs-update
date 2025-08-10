#!/usr/bin/env bash

# Check if the script is run as root; exit with a message if not
if [[ $(id -u) -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Check if wget is installed; exit with a message if not
if ! command -v wget &> /dev/null; then
    echo "Please install the wget package"
    exit 1
fi

# Check if unzip is installed; exit with a message if not
if ! command -v unzip &> /dev/null; then
    echo "Please install the unzip package"
    exit 1
fi

INSTALL_DIR="/opt/aacs-updater"
# Check if /opt/aacs-updater directory exists; create it if not
if [[ ! -d "$INSTALL_DIR" ]]; then
    mkdir -p "$INSTALL_DIR"
fi

# Check if required files exist before copying; exit with a message if any are missing
for file in aacs-updater.sh aacs-update.service aacs-update.timer; do
    if [[ ! -f $file ]]; then
        echo "Missing file: $file"
        exit 1
    fi
done

# Copy the updater script and systemd unit files to their locations
cp aacs-updater.sh "$INSTALL_DIR"
cp aacs-update.service /etc/systemd/system/
cp aacs-update.timer /etc/systemd/system/

# Enable the systemd timer and start the systemd service
systemctl enable aacs-update.timer
systemctl start aacs-update.service
