import QtQuick
import QtQuick.Layouts
import "../config"
import "../components"
import "../services"

// Replaces widgets/bar/system_stats.yuck (CPU/mem/temp only - updates and
// battery live in MenuBar.qml, matching the original menu.yuck split).
RowLayout {
    id: root
    spacing: 8

    JsonPoller {
        id: statsPoller
        scriptPath: Paths.script("system_stats.sh")
        interval: 2000
    }
    readonly property var d: statsPoller.data

    StatItem {
        icon: root.d.cpu_icon || ""
        label: root.d.cpu_usage !== undefined ? String(root.d.cpu_usage) : "--"
        highlightColor: Colors.stateColor(root.d.cpu_state)
    }
    StatItem {
        icon: root.d.memory_icon || ""
        label: root.d.memory_usage !== undefined ? root.d.memory_usage + "%" : "--%"
        highlightColor: Colors.stateColor(root.d.memory_state)
    }
    StatItem {
        icon: root.d.temp_icon || ""
        label: root.d.temp_lvl !== undefined ? root.d.temp_lvl + "\u00b0C" : "--\u00b0C"
        highlightColor: Colors.stateColor(root.d.temp_state)
    }
}
