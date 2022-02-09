#!/usr/bin/env bash

blue=$(systemctl list-units --all -t service --full --no-legend "bluetooth.service")
if [[ $blue ]]; then
	pacman --noconfirm -S bluez bluez-utils blueberry
	systemctl enable bluetooth.service
fi
