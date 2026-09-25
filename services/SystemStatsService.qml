// services/SystemStatsService.qml
pragma Singleton
import QtQuick

Item {
    id: root
    readonly property int historyLength: 60

    property real cpuUsage: 0
    property string cpuState: ""
    property var cpuHistory: []

    property real memUsage: 0
    property string memState: ""
    property var memHistory: []

    property real tempLvl: 0
    property string tempState: ""
    property var tempHistory: []

    function pushHistory(arr, value) {
        arr.push(value)
        if (arr.length > historyLength) arr.shift()
        return arr
    }

    Poller {
        id: poller
        command: "~/.config/quickshell/hypr_bar_qml/scripts/system_stats.sh"
        interval: 2000
        onDataChanged: {
            // console.log("temp_icon raw:", JSON.stringify(data.temp_icon), "length:", data.temp_icon.length, "code:", data.temp_icon.length ? data.temp_icon.charCodeAt(0) : "empty")
            root.cpuUsage = parseFloat(data.cpu_usage); root.cpuState = data.cpu_state
            root.memUsage = parseFloat(data.memory_usage); root.memState = data.memory_state
            root.tempLvl = parseFloat(data.temp_lvl); root.tempState = data.temp_state

            root.cpuHistory = pushHistory(root.cpuHistory, root.cpuUsage)
            root.memHistory = pushHistory(root.memHistory, root.memUsage)
            root.tempHistory = pushHistory(root.tempHistory, root.tempLvl)
        }
    }
    
}