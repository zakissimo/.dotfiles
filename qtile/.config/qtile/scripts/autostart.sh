#!/usr/bin/env bash

wal -R &
picom &

nm-applet &
pa-applet &
megasync &
blueman-applet &
# gxkb &

cbatticon -u 20 -i notification -c "poweroff" -l 15 -r 3 &

key &
