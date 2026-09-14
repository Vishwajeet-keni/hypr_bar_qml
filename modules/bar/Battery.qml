import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import "../../config"

RowLayout {
    id: root
    spacing: 5

    readonly property var battery: UPower.displayDevice
    readonly property bool ready: battery.ready && battery.isPresent
    readonly property int level: Math.round(battery.percentage * 100)
    readonly property bool charging: battery.state === UPowerDeviceState.Charging || battery.state === UPowerDeviceState.PendingCharge
    readonly property bool critical: ready && level <= 30
    readonly property bool shouldWarn: critical && battery.state === UPowerDeviceState.Discharging

    visible: root.ready // no battery on this machine -> widget just isn't shown

    readonly property string icon: {
        if (charging) return "\uf0e7"
        if (level >= 90) return "\uf240"
        if (level >= 60) return "\uf241"
        if (level >= 40) return "\uf242"
        if (level >= 10) return "\uf243"
        return "\uf244"
    }
    readonly property color stateColor: {
        if (critical) return "red"
        if (charging) return "green"
        return "whitesmoke"
    }

    onShouldWarnChanged: {
        if (shouldWarn && !AppState.lowBattShown) {
            AppState.lowBattVisible = true
            AppState.lowBattShown = true
        } else if (!shouldWarn) {
            AppState.lowBattShown = false
        }
    }

    Text {
        text: root.icon
        color: root.stateColor
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: Vars.fontBase
    }
    Text {
        text: root.level + "%"
        color: root.stateColor
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: Vars.fontBase
        font.bold: true
    }
}