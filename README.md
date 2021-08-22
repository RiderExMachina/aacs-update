# AACS Updater

Adds a SystemD timer that updates the AACS KEYDB file for playing bluray disks. By default it runs on Friday at 8pm, but it is possible to edit the Timer file to change to a better day.

To install, run the included install script: `sudo ./install.sh`. If you get a Permission Denied error, give the script executable permissions with `chmod +x install.sh`.

Please verify your installation is successful by running `systemctl status aacs-updater` and checking the "Active" status (it should say "Running" in green).
