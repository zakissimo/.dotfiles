#!/bin/sh

# xrdb merge ~/.Xresources
# feh --bg-fill ~/Pictures/wall/gruv.png &

xset s off -dpms &

sxhkd &
picom &
dunst &

pa-applet &
nm-applet &
blueman-applet &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

dash ~/.config/chadwm/scripts/bar.sh &
while type chadwm >/dev/null; do chadwm && continue || break; done
