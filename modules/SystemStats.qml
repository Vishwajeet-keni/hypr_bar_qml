import QtQuick
import QtQuick.Layouts
import Quickshell
import "../config"
import "../components"
import "../services"

RowLayout {
    id: root
    spacing: 6

    JsonPoller {
        id: statsPoller
        scriptPath: Quickshell.shellPath("hypr_bar_qml/scripts/system_stats.sh")
        interval: 2000
    }

    JsonPoller {
        id: updatesPoller
        scriptPath: Quickshell.shellPath("hypr_bar_qml/scripts/updates.sh")
        interval: 300000
    }

    JsonPoller {
        id: battPoller
        scriptPath: Quickshell.shellPath("hypr_bar_qml/scripts/battery.sh")
        interval: 5000
    }

    // Arch Updates
    StatItem {
        visible: updatesPoller.data && updatesPoller.data.updates > 0
        icon: "󰏔"
        label: updatesPoller.data ? updatesPoller.data.updates : "0"
        highlightColor: Colors.accentPeach
    }

    // CPU Stat
    StatItem {
        icon: ""
        label: (statsPoller.data && statsPoller.data.cpu !== undefined) ? statsPoller.data.cpu + "%" : "--%"
        highlightColor: Colors.accentTeal
    }

    // RAM Stat
    StatItem {
        icon: ""
        label: (statsPoller.data && statsPoller.data.ram !== undefined) ? statsPoller.data.ram + "%" : "--%"
        highlightColor: Colors.accentGreen
    }

    // Temp Stat
    StatItem {
        icon: ""
        label: (statsPoller.data && statsPoller.data.temp !== undefined) ? statsPoller.data.temp + "°C" : "--°C"
        highlightColor: Colors.accentPeach
    }

    // Battery Bar Stat
    StatItem {
        icon: battPoller.data && battPoller.data.charging ? "󰂄" : (battPoller.data && battPoller.data.capacity > 20 ? "󰁹" : "󰂃")
        label: (battPoller.data && battPoller.data.capacity !== undefined) ? battPoller.data.capacity + "%" : "--%"
        highlightColor: battPoller.data && battPoller.data.capacity <= 20 && !battPoller.data.charging ? Colors.accentRed : Colors.accentLavender
        alert: battPoller.data && battPoller.data.capacity <= 15 && !battPoller.data.charging
    }
}