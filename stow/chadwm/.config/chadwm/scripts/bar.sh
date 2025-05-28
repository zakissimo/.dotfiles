#!/usr/bin/env bash

battery() {
    percentage="$(cat /sys/class/power_supply/BAT*/capacity)"

    case "$(cat /sys/class/power_supply/BAT*/status)" in
    Full | "Not charging") printf " %s" "Full" ;;
    Charging) printf " %s (%s%%)" "Charging" "$percentage" ;;
    Discharging)
        case "$percentage" in
        9[0-9] | 100)
            printf "󰁹 "
            ;;
        7[0-9] | 8[0-9])
            printf "󰂂 "
            ;;
        5[0-9] | 6[0-9])
            printf "󰁿 "
            ;;
        3[0-9] | 4[0-9])
            printf "󰁼 "
            ;;
        1[0-9] | 2[0-9])
            printf "󰁻 "
            ;;
        0*[0-9])
            printf "󰁺 "
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

    printf "🔻%4sB/s 🔺%4sB/s\\n" $(numfmt --to=iec $rx $tx)
}

today() {
    today=$(date '+%a %d %b')
    printf "󰃭 %s" "$today"
}

clock() {
    time=$(date '+%H:%M')
    ny_time=$(TZ="America/New_York" date "+%H:%M")
    printf "󱑆 %s  %s" "$time" "$ny_time"
}

time_for_salat() {
    time=$(. ~/.env && ~/.local/bin/time_for_salat)
    printf " %s" "$time"
}

while true; do
    sleep 3 && xsetroot -name "  $(cpu) $(mem) | $(net) | $(battery) | $(today) $(clock) | $(time_for_salat) "
done
