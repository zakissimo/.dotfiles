#!/bin/bash

[[ -f ~/.Xresources ]] && xrdb ~/.Xresources
[[ -f ~/.xprofile ]] && xrdb ~/.xprofile
sxhkd &

while type dwm >/dev/null ; do dwm && continue || break ; done
