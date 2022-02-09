#!/usr/bin/env bash

if [ -d "/proc/acpi/button/lid" ]; then
	pacman --noconfirm -S bluez bluez-utils blueberry cbatticon
	systemctl enable bluetooth.service
else
	echo "According to my calculations, this machine isn't a laptop. See ya!"
fi
