#!/usr/bin/env bash

if [ -d "/proc/acpi/button/lid" ]; then
	sudo pacman --noconfirm -S bluez bluez-utils blueman cbatticon tlp
	systemctl enable bluetooth.service
	systemctl enable tlp.service
else
	echo "According to my calculations, this machine isn't a laptop. See ya!"
fi
