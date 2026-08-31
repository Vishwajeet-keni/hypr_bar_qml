#!/bin/bash
# Adapted from the original eww hypr_bar battery.sh:
#   - dropped the `eww open low_batt_warning` call and the /tmp shown-flag
#     bookkeeping - Quickshell's shell.qml now owns that decision, driven
#     off the new "status" field below.
#   - added "status" (raw Charging/Discharging/Full) to the JSON output,
#     since "class" gets overwritten to "critical" at low battery and the
#     original charge state would otherwise be lost.
# Everything else (icon selection, upower --monitor loop) is unchanged.

emit() {
    if [ ! -d "/sys/class/power_supply/BAT0" ]; then
        echo "{\"icon\":\"󰂃\", \"level\":\"--\", \"class\":\"no-battery\", \"status\":\"none\"}"
        return
    fi

    level=$(cat /sys/class/power_supply/BAT0/capacity)
    status=$(cat /sys/class/power_supply/BAT0/status)

    if [ "$status" = "Charging" ]; then
        icon=""
    else
        case $level in
            9[0-9]|100) icon="" ;;
            [6-8][0-9]) icon="" ;;
            [4-5][0-9]) icon="" ;;
            [1-3][0-9]) icon="" ;;
            *) icon="" ;;
        esac
    fi

    class="$status"
    low_batt=30

    [ "$level" -le $low_batt ] && class="critical"

    echo "{\"icon\":\"$icon\", \"level\":\"$level\", \"class\":\"$class\", \"status\":\"$status\"}"
}

if [ ! -d "/sys/class/power_supply/BAT0" ]; then
    emit
    exit 0
fi

emit

(
  while true; do
    sleep 30
    emit
  done
) &
timer_pid=$!
trap 'kill "$timer_pid" 2>/dev/null' EXIT

upower --monitor | while read -r line; do
    case "$line" in
        *"device changed"*|*"state changed"*|*"percentage"*)
            emit
            ;;
    esac
done
