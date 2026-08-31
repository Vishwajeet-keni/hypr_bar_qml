import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    property var pal
    spacing: 8

    JsonPoller {
        id: poller
        script: "$HOME/.config/quickshell/scripts/system_stats.sh"
        interval: 2000
    }

    readonly property var d: poller.data

    StatItem {
        pal: root.pal
        icon: root.d.cpu_icon || ""
        label: root.d.cpu_usage !== undefined ? root.d.cpu_usage + "%" : "--"
        state: root.d.cpu_state || ""
    }
    StatItem {
        pal: root.pal
        icon: root.d.memory_icon || ""
        label: root.d.memory_usage !== undefined ? root.d.memory_usage + "%" : "--"
        state: root.d.memory_state || ""
    }
    StatItem {
        pal: root.pal
        icon: root.d.temp_icon || ""
        label: root.d.temp_lvl !== undefined ? root.d.temp_lvl + "\u00b0C" : "--"
        state: root.d.temp_state || ""
    }
}
