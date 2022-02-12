#!/usr/bin/env bash

nm-applet &
megasync &
dunst &
pa-applet &
"$HOME/MEGA/Apps/g14_alert" &

blue=$(systemctl list-units --all -t service --full --no-legend "bluetooth.service")
if [[ $blue ]]; then
	blueman-applet &
fi
