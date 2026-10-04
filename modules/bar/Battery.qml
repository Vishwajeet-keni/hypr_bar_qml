import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import "../../assets"
import "../../config"


RowLayout {
    id: root
    spacing: 3

    readonly property var battery: UPower.displayDevice
    readonly property var profile: PowerProfiles.profile
    readonly property bool ready: battery.ready && battery.isPresent
    readonly property int level: Math.round(battery.percentage * 100)
    readonly property bool charging: battery.state === UPowerDeviceState.Charging || battery.state === UPowerDeviceState.PendingCharge
    readonly property bool critical: ready && level <= 30
    readonly property bool shouldWarn: critical && battery.state === UPowerDeviceState.Discharging

    visible: root.ready // no battery on this machine -> widget just isn't shown

    readonly property string battery_lvl: {
        if (level >= 90) return Icons.battery.lvl[4]
        if (level >= 60) return Icons.battery.lvl[3]
        if (level >= 40) return Icons.battery.lvl[2]
        if (level >= 10) return Icons.battery.lvl[1]
        return Icons.battery.lvl[0]
    }
    
    readonly property string icon: {
        if (charging) return Icons.battery.Charging + battery_lvl
        if (profile != PowerProfile.Balanced) {
            return Icons.battery[PowerProfile.toString(profile)] + battery_lvl
        }
        return battery_lvl
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
        color: Colors.batteryColor(critical, charging, profile)
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: Vars.fontBase
    }
    Text {
        text: root.level + "%"
        color: Colors.batteryColor(critical, charging, profile)
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: Vars.fontBase
        font.bold: true
    }
}