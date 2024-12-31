#!/usr/bin/env bash

# ^c$var^ = fg color
# ^b$var^ = bg color

# load colors
# . ~/.config/chadwm/scripts/bar_themes/rosepine

battery() {
    percentage="$(cat /sys/class/power_supply/BAT*/capacity)"

    case "$(cat /sys/class/power_supply/BAT*/status)" in
    Full) printf " %s" "Full" ;;
    Charging) printf " %s" "Charging" ;;
    Discharging)
        case "$(cat /sys/class/power_supply/BAT*/status)" in
        90)
            printf "󰁹 "
            ;;
        70)
            printf "󰂂 "
            ;;
        50)
            printf "󰁿 "
            ;;
        30)
            printf "󰁼 "
            ;;
        10)
            printf "󰁻 "
            ;;
        *)
            printf "󰁺 "
            ;;
        esac
        printf "%s%%" "$percentage"
        ;;
    esac

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
    while read -r status; do
        [ "$status" == "up" ] && printf "󰈀 %s" "Connected" && return
    done < <(cat /sys/class/net/e*/operstate 2>/dev/null)

    case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
    up) printf "󰤨 %s" "Connected" ;;
    down) printf "󰤭 %s" "Disconnected" ;;
    esac
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
    sleep 3 && xsetroot -name "  $(battery) $(cpu) $(mem) $(net) $(clock) $(time_for_salat)"
done
