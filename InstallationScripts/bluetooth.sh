#!/usr/bin/env bash

systemctl list-units --all -t service --full --no-legend "bluetooth.service"

pacman --noconfirm -S bluez bluez-utils blueberry
systemctl enable bluetooth.service
