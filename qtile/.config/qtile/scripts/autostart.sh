#!/usr/bin/env bash

#xrandr --output HDMI-A-1 --auto --left-of HDMI-A-0
#xset s off -dpms
#key &
#wal -R &
#picom -b &
nm-applet &
megasync &
pa-applet &
dunst &
"$HOME/MEGA/Apps/g14_alert" &

blue=$(systemctl list-units --all -t service --full --no-legend "bluetooth.service")
if [[ $blue ]]; then
	blueman-applet &
fi

#flux location & start
# lat_lng=$(curl ipinfo.io/loc)
# lat=$(echo "$lat_lng" | cut -d ',' -f 1)
# lng=$(echo "$lat_lng" | cut -d ',' -f 2)
# xflux -l "$lat" -g "$lng" &
