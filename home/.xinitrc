#!/bin/bash

wal -R
picom &
sxhkd &

key
barrierc --disable-crypto 192.168.1.19
bash "$HOME/Apps/bar.sh" &
pidof polkit-gnome-authentication-agent-1 1>/dev/null || /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

while type dwm >/dev/null ; do dwm && continue || break ; done
