#!/usr/bin/env bash

# xrdb merge ~/.Xresources

for next in $(xrandr | grep " connected " | cut -d' ' -f1); do
    [ -z "$current" ] && current=$next && continue
    xrandr --output "$current" --auto --output "$next" --auto --left-of "$current"
    current=$next
done

sxhkd &
picom &
dunst &

pa-applet &
nm-applet &
blueman-applet &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

~/.config/chadwm/scripts/bar.sh &

xset s off -dpms &
xset r rate 200 50

setxkbmap -model pc105 -layout us_qwerty-fr,ara -option grp:alt_shift_toggle

while type chadwm >/dev/null; do chadwm && continue || break; done
