import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../config"
import "../services"

// Replaces widgets/bar/menu.yuck (updates + wifi + battery + the button
// that opens the control panel). Flat, no per-item boxes - matches the
// bar's shared-background look, unlike the boxed Control Center tiles.
RowLayout {
    id: root
    spacing: 8

    JsonPoller {
        id: updatesPoller
        scriptPath: Paths.script("updates.sh")
        interval: 300000
    }
    JsonPoller {
        id: wifiPoller
        scriptPath: Paths.script("wifi.sh")
        interval: 5000
    }
    JsonPoller {
        id: battPoller
        scriptPath: Paths.script("battery.sh")
        interval: 5000
    }

    readonly property color battColor: {
        const cls = battPoller.data.class
        if (cls === "critical") return Colors.accentRed
        if (cls === "Charging") return Colors.accentGreen
        return Colors.textPrimary
    }

    // ── Updates ──
    Item {
        implicitWidth: updRow.implicitWidth
        implicitHeight: updRow.implicitHeight
        visible: (updatesPoller.data.count || "0") !== "0"

        RowLayout {
            id: updRow
            anchors.fill: parent
            spacing: 5
            Text { text: "\uf021"; color: Colors.textSecondary; font.family: "JetBrains Mono Nerd Font"; font.pixelSize: 12 }
            Text {
                text: updatesPoller.data.count !== undefined ? updatesPoller.data.count : "?"
                color: Colors.textSecondary
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 12
                font.bold: true
            }
        }
        MouseArea { id: maUpd; anchors.fill: parent; hoverEnabled: true }
        ToolTip.visible: maUpd.containsMouse
        ToolTip.text: "pacman: " + (updatesPoller.data.pacman_u ?? "?") + "\nyay: " + (updatesPoller.data.yay_u ?? "?")
    }

    // ── Wifi ──
    Item {
        implicitWidth: wifiLabel.implicitWidth
        implicitHeight: wifiLabel.implicitHeight
        Text {
            id: wifiLabel
            text: wifiPoller.data.icon || "\u{f05aa}"
            color: Colors.textPrimary
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 14
        }
        MouseArea {
            id: maWifi
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: wifiPoller.poll(["toggle"])
        }
        ToolTip.visible: maWifi.containsMouse
        ToolTip.text: wifiPoller.data.status || ""
    }

    // ── Battery ──
    RowLayout {
        spacing: 5
        Text {
            text: battPoller.data.icon || ""
            color: root.battColor
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 13
        }
        Text {
            text: (battPoller.data.level || "--") + "%"
            color: root.battColor
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 12
            font.bold: true
        }
    }

    // ── Control panel toggle ──
    Item {
        implicitWidth: menuLabel.implicitWidth + 2
        implicitHeight: menuLabel.implicitHeight
        Text {
            id: menuLabel
            text: "\u{f07e1}"
            color: AppState.controlCenterOpen ? Colors.accentBlue : Colors.textPrimary
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 15
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: AppState.controlCenterOpen = !AppState.controlCenterOpen
        }
    }
}
