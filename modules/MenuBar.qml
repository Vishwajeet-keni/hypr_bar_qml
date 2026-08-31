import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

// Replaces widgets/bar/menu.yuck (updates + wifi + battery + the gear
// button that opens the control panel).
RowLayout {
    id: root
    property var pal
    property var state
    spacing: 8

    JsonPoller {
        id: updatesPoller
        script: "$HOME/.config/quickshell/scripts/updates.sh"
        interval: 3600000 // 1 hour, same as the original defpoll
    }
    JsonPoller {
        id: wifiPoller
        script: "$HOME/.config/quickshell/scripts/wifi.sh"
        interval: 5000
    }

    // ── Updates ──
    Item {
        implicitWidth: updRow.implicitWidth
        implicitHeight: updRow.implicitHeight
        RowLayout {
            id: updRow
            spacing: 6
            Text { text: "\uf021"; color: root.pal.textPrimary; font.pixelSize: 12 }
            Text {
                text: updatesPoller.data.count !== undefined ? updatesPoller.data.count : "?"
                color: root.pal.textPrimary
                font.pixelSize: 13
                font.bold: true
            }
        }
        MouseArea { id: maUpd; anchors.fill: parent; hoverEnabled: true }
        ToolTip.visible: maUpd.containsMouse
        ToolTip.text: "pacman: " + (updatesPoller.data.pacman_u ?? "?") + "\nyay: " + (updatesPoller.data.yay_u ?? "?")
    }

    // ── Wifi ──
    Item {
        implicitWidth: wifiLabel.implicitWidth + 6
        implicitHeight: wifiLabel.implicitHeight
        Text {
            id: wifiLabel
            anchors.centerIn: parent
            text: wifiPoller.data.icon || "\u{f05aa}"
            color: root.pal.textPrimary
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
        ToolTip.text: wifiPoller.data.ssid || ""
    }

    // ── Battery ── (fed by the shared battery stream in shell.qml)
    RowLayout {
        spacing: 6
        Text {
            text: root.state.batteryData.icon || ""
            color: root.pal.stateColor(root.state.batteryData.class)
            font.pixelSize: 13
        }
        Text {
            text: (root.state.batteryData.level || "--") + "%"
            color: root.pal.stateColor(root.state.batteryData.class)
            font.pixelSize: 13
            font.bold: true
        }
    }

    // ── Control panel toggle (the "menu-btn" gear icon) ──
    Item {
        implicitWidth: menuLabel.implicitWidth + 8
        implicitHeight: menuLabel.implicitHeight
        Text {
            id: menuLabel
            anchors.centerIn: parent
            text: "\u{f01d9}"
            color: root.pal.textPrimary
            font.pixelSize: 16
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.state.controlPanelOpen = !root.state.controlPanelOpen
            onExited: ccCloseTimer.restart()
            onEntered: ccCloseTimer.stop()
        }
        Timer { id: ccCloseTimer; interval: 300; onTriggered: root.state.controlPanelOpen = false }
    }
}
