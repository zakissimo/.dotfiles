#!/usr/bin/env bash

if [ -d "/proc/acpi/button/lid" ]; then
	sudo pacman --noconfirm -S bluez bluez-utils blueman cbatticon
	systemctl enable bluetooth.service
else
	echo "According to my calculations, this machine isn't a laptop. See ya!"
fi
