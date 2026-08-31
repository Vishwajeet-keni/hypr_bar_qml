import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../config"
import "../services"

PanelWindow {
    id: battWarn

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "hyprbar-batt"

    JsonPoller {
        id: battPoller
        scriptPath: Quickshell.shellPath("hypr_bar_qml/scripts/battery.sh")
        interval: 10000
    }

    readonly property bool isLow: battPoller.data && battPoller.data.capacity <= 15 && !battPoller.data.charging

    visible: isLow

    anchors {
        top: true
    }
    margins {
        top: 48
    }

    width: 320
    height: 54
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 12
        color: Qt.rgba(Colors.accentRed.r, Colors.accentRed.g, Colors.accentRed.b, 0.95)
        border.color: Colors.textPrimary
        border.width: 1

        RowLayout {
            anchors.centerIn: parent
            spacing: 12

            Text {
                text: "󰂃"
                color: "#ffffff"
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 24
            }

            ColumnLayout {
                spacing: 1

                Text {
                    text: "Low Battery Warning"
                    color: "#ffffff"
                    font.family: "JetBrains Mono Nerd Font"
                    font.bold: true
                    font.pixelSize: 12
                }

                Text {
                    text: "Battery is at " + (battPoller.data ? battPoller.data.capacity : 0) + "% — Connect charger!"
                    color: "#f5c2e7"
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 10
                }
            }
        }
    }
}