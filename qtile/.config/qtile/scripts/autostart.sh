#!/usr/bin/env bash

wal -R &
picom &

nm-applet &
pa-applet &
megasync &
blueman-applet &
sxhkd &
# gxkb &

# Run once
# asusctl led-mode static -c ffffff

cbatticon -u 20 -i notification -c "poweroff" -l 15 -r 3 &

input-remapper-control --command autoload

key
