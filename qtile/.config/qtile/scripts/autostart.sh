#!/usr/bin/env bash

nm-applet &
megasync &
pa-applet &
dunst &

blue=$(systemctl list-units --all -t service --full --no-legend "bluetooth.service")
if [[ $blue ]]; then
	blueberry-tray &
fi

#flux location & start
# lat_lng=$(curl ipinfo.io/loc)
# lat=$(echo "$lat_lng" | cut -d ',' -f 1)
# lng=$(echo "$lat_lng" | cut -d ',' -f 2)
# xflux -l "$lat" -g "$lng" &
