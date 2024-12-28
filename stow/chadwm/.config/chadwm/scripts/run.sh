#!/bin/sh

# xrdb merge ~/.Xresources
# feh --bg-fill ~/Pictures/wall/gruv.png &

xset s off -dpms &
xset r rate 200 50 &

sxhkd &
picom &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

for next in $(xrandr --listmonitors | grep -E " *[0-9]+:.*" | cut -d" " -f6); do
    [ -z "$current" ] && current=$next && continue
    xrandr --output $current --auto --output $next --auto --left-of $current
    current=$next
done

dash ~/.config/chadwm/scripts/bar.sh &
while type chadwm >/dev/null; do chadwm && continue || break; done
