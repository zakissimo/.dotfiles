#!/bin/bash

[[ -f ~/.Xresources ]] && xrdb ~/.Xresources
[[ -f ~/.xprofile ]] && xrdb ~/.xprofile

wal -R
picom &
sxhkd &

key

while type dwm >/dev/null ; do dwm && continue || break ; done
