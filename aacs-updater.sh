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

if ! wget "http://fvonline-db.bplaced.net/export/keydb_eng.zip" -O "$TMP_ZIP"; then
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

getent passwd | while IFS=: read -r USERNAME _ _ _ _ HOMEDIR _; do
    CONFIG_DIR="$HOMEDIR/.config/aacs"
    if [ -d "$CONFIG_DIR" ]; then
        [ -f "$CONFIG_DIR/KEYDB.cfg" ] && cp "$CONFIG_DIR/KEYDB.cfg" "$CONFIG_DIR/KEYDB.cfg.bak"
        cp "$TMP_CFG" "$CONFIG_DIR/KEYDB.cfg"
        chown "$USERNAME":"$USERNAME" "$CONFIG_DIR/KEYDB.cfg"
        log "Updated KEYDB.cfg for $USERNAME"
    fi
done

log "Cleaning up"
rm -f "$TMP_ZIP" "$TMP_CFG"
