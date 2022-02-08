#!/usr/bin/env bash

xrandr --output HDMI-A-1 --auto --left-of HDMI-A-0
xset s off -dpms
wal -R
picom -b

nm-applet &
megasync &
pa-applet &
dunst &

sleep 1

#Faster cursor
xset r rate 300 50
setxkbmap -option caps:super
killall xcape 2>/dev/null
xcape -e 'Super_L=Escape'
setxkbmap -model pc105 -layout fr,ara -variant oss_nodeadkeys, -option grp:alt_shift_toggle

# sleep 3

#flux location & start
# lat_lng=$(curl ipinfo.io/loc)
# lat=$(echo "$lat_lng" | cut -d ',' -f 1)
# lng=$(echo "$lat_lng" | cut -d ',' -f 2)
# xflux -l "$lat" -g "$lng" &
