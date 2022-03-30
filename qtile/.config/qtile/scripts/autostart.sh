#!/usr/bin/env bash

wal -R &
picom -b &

nm-applet &
pa-applet &
megasync &
# gxkb &

"$HOME/MEGA/Apps/g14_alert" &

if [ -d "/proc/acpi/button/lid" ]; then
	cbatticon -u 20 -i notification -c "poweroff" -l 15 -r 3 &
fi

blue=$(systemctl list-units --all -t service --full --no-legend "bluetooth.service")
if [[ $blue ]]; then
	blueman-applet &
fi

key &
