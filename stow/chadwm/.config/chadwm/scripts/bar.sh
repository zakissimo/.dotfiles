#!/usr/bin/env bash

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

net_update() {
    sum=0
    for arg; do
        read -r i <"$arg"
        sum=$((sum + i))
    done
    cache=/tmp/${1##*/}
    [ -f "$cache" ] && read -r old <"$cache" || old=0
    printf %d\\n "$sum" >"$cache"
    printf %d\\n $((sum - old))
}

net() {
    rx=$(net_update /sys/class/net/[ew]*/statistics/rx_bytes)
    tx=$(net_update /sys/class/net/[ew]*/statistics/tx_bytes)

    printf "🔻%4sB 🔺%4sB\\n" $(numfmt --to=iec $rx $tx)
}

today() {
    date=$(date +"%a %d %b")

    printf "󰃭 %s" "$date"
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
    sleep 3 && xsetroot -name "  $(cpu) $(mem) | $(net) | $(battery) | $(today) $(clock) | $(time_for_salat)"
done
