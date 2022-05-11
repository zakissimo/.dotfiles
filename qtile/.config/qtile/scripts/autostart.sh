#!/usr/bin/env bash

wal -R &
picom &

nm-applet &
pa-applet &
megasync &
blueman-applet &
# gxkb &

"$HOME/MEGA/Apps/g14_alert" &

if [ -d "/proc/acpi/button/lid" ]; then
	cbatticon -u 20 -i notification -c "poweroff" -l 15 -r 3 &
fi

key &
