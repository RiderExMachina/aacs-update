# AACS Updater

### TL;DR
AACS Updater a SystemD timer that updates the AACS KEYDB file for playing bluray disks. By default it runs on Friday at 8pm, but it is possible to edit the Timer file to change to a better day.


### Install

To install, run the included install script: `sudo ./install.sh`. If you get a Permission Denied error, give the script executable permissions with `chmod +x install.sh`.

Please verify your installation is successful by running `systemctl status aacs-updater` and checking the "Active" status (it should say "Running" in green).

### How it works

This updater pulls a zip file from http://fvonline-db.bplaced.net/ every Friday evening and unzips it to /tmp/aacs.zip. It then extracts the KEYDB.cfg file and copies it to every user's /home directory (after checking the user exists on the system first). This should fit most edgecases, in case multiple people using one computer need the most up-to-date KEYDB, or if there's a lingering userfolder in /home.

The website listed above seems to be the current "source of truth", so I'll be keeping it for the time being. If a better website comes along, please let me know, and I'll change it.
