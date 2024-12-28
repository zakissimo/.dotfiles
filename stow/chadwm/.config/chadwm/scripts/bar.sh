#!/bin/dash

# ^c$var^ = fg color
# ^b$var^ = bg color

# load colors
# . ~/.config/chadwm/scripts/bar_themes/rosepine

get_battery_icon() {
    percentage="$(cat /sys/class/power_supply/BAT0/capacity)"

    if [ "$percentage" -eq 100 ]; then
        printf " "
    elif [ "$percentage" -ge 90 ]; then
        printf "󰁹 "
    elif [ "$percentage" -ge 70 ]; then
        printf "󰂂 "
    elif [ "$percentage" -ge 50 ]; then
        printf "󰁿 "
    elif [ "$percentage" -ge 30 ]; then
        printf "󰁼 "
    elif [ "$percentage" -ge 10 ]; then
        printf "󰁻 "
    else
        printf "󰁺 "
    fi
    printf "%s%%" "$percentage"
}

battery() {
    battery_icon=$(get_battery_icon)
    printf "%s" "$battery_icon"
}

cpu() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

    printf " %s%%" "$cpu_usage"
}

mem() {
    memory_usage=$(top -bn1 | grep "MiB Mem" | awk '{printf "%.1f", $8/$4 * 100.0}')

    printf " %s%%" "$memory_usage"
}

net() {
    eth_down=1
    [ "up" = "$(cat /sys/class/net/eth*/operstate 2>/dev/null)" ] && printf "󰈀 %s" "Connected" && eth_down=0
    [ "up" = "$(cat /sys/class/net/enp*/operstate 2>/dev/null)" ] && printf "󰈀 %s" "Connected" && eth_down=0

    if [ "$eth_down" -eq 1 ]; then
        case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
        up) printf "󰤨 %s" "Connected" ;;
        down) printf "󰤭 %s" "Disconnected" ;;
        esac
    fi
}

clock() {
    time=$(date '+%H:%M')
    printf "󱑆 %s" "$time"
}

time_for_salat() {
    time=$(. ~/.env && ~/.local/bin/time_for_salat)
    printf " %s" "$time"
}

while true; do
    sleep 5 && xsetroot -name "  $(battery) $(cpu) $(mem) $(net) $(clock) $(time_for_salat)"
done
