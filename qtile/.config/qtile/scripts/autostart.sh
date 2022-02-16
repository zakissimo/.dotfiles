#!/usr/bin/env bash

wal -R &
picom -b &

nm-applet &
megasync &
gxkb &
key &
"$HOME/MEGA/Apps/g14_alert" &

blue=$(systemctl list-units --all -t service --full --no-legend "bluetooth.service")
if [[ $blue ]]; then
	blueman-applet &
fi
