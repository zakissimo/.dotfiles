#!/usr/bin/env bash

#Load correct screen positions
xrandr --output DVI-D-0 --left-of HDMI-A-0
#Remember last wal settings
wal -R
#Launch picom
picom -b
#network manager
nm-applet &
#Cloud
megasync &
#Emacs daemon (faster starting time)
emacs --daemon &

sleep 1

#Faster cursor
xset r rate 300 50
#Remapping caps lock to super
setxkbmap -option caps:super
#Acts as escape when pressed once
killall xcape 2>/dev/null; xcape -e 'Super_L=Escape'
#Double layout fr/ara
setxkbmap -model pc105 -layout fr,ara -variant oss_nodeadkeys, -option grp:alt_shift_toggle

sleep 3

#flux location & start
lat_lng=$(curl ipinfo.io/loc)
lat=$(echo $lat_lng | cut -d ',' -f 1)
lng=$(echo $lat_lng | cut -d ',' -f 2)
xflux -l $lat -g $lng &
