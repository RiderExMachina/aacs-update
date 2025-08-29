#!/bin/bash
set -euo pipefail

LOGFILE="/var/log/aacs-updater.log"

log() {
	echo "$1"
    echo "$(date -u) - $1" >> "$LOGFILE"
}

TMP_ZIP="/tmp/aacs.zip"
TMP_CFG="/tmp/keydb.cfg"

log "Starting AACS update"

#"http://fvonline-db.bplaced.net/export/keydb_eng.zip"
if ! wget "http://fvonline-db.bplaced.net/fv_download.php?lang=eng" -O "$TMP_ZIP"; then
    log "ERROR: Failed to download AACS keys"
    exit 1
fi

if ! unzip "$TMP_ZIP" -d /tmp; then
    log "ERROR: Failed to unzip AACS keys"
    exit 1
fi

if [ ! -f "$TMP_CFG" ]; then
    log "ERROR: keydb.cfg not found"
    exit 1
fi

for USERNAME in $(ls /home); do
    HOMEDIR="/home/$USERNAME"
    CONFIG_DIR="$HOMEDIR/.config/aacs"
    if [ ! -d "$CONFIG_DIR" ]; then
        log "Creating $CONFIG_DIR"
        mkdir "$CONFIG_DIR"
    fi
    cp "$TMP_CFG" "$CONFIG_DIR/KEYDB.cfg"
    chown "$USERNAME":"$USERNAME" -R "$CONFIG_DIR/"
    chmod 775 -R "$CONFIG_DIR/"
    log "Updated KEYDB.cfg for $USERNAME"
done

log "Cleaning up"
rm -f "$TMP_ZIP" "$TMP_CFG"
