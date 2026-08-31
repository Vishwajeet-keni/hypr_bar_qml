import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../config"
import "../components"

PanelWindow {
    id: barRoot

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "hyprbar"
    WlrLayershell.exclusiveZone: 40

    anchors {
        top: true
        left: true
        right: true
    }
    height: 40
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        anchors.margins: 4
        radius: 10
        color: Colors.bgGlass
        border.color: Colors.borderColor
        border.width: 1

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            spacing: 8

            // Left
            MenuBar {}
            Workspaces {}

            Item { Layout.fillWidth: true }

            // Center
            TimeDate {}

            Item { Layout.fillWidth: true }

            // Right
            SystemStats {}

            Rectangle {
                width: 28
                height: 28
                radius: 7
                color: AppState.controlCenterOpen ? Qt.rgba(Colors.accentBlue.r, Colors.accentBlue.g, Colors.accentBlue.b, 0.25) : Colors.surfaceBg
                border.color: AppState.controlCenterOpen ? Colors.accentBlue : Colors.borderSubtle
                border.width: 1

                Behavior on color { ColorAnimation { duration: 150 } }

                Text {
                    anchors.centerIn: parent
                    text: "󱄅"
                    color: AppState.controlCenterOpen ? Colors.accentBlue : Colors.textPrimary
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: AppState.controlCenterOpen = !AppState.controlCenterOpen
                }
            }
        }
    }
}