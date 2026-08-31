import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../config"

PanelWindow {
    id: calWindow

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "hyprbar-cal"

    visible: AppState.calendarOpen

    anchors {
        top: true
    }
    margins {
        top: 42
    }

    width: 290
    height: 140
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 12
        color: Colors.bgGlass
        border.color: Colors.borderColor
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 14
            spacing: 6

            Text {
                text: Qt.formatDateTime(new Date(), "hh:mm:ss A")
                color: Colors.accentMauve
                font.family: "JetBrains Mono Nerd Font"
                font.bold: true
                font.pixelSize: 22
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: Qt.formatDateTime(new Date(), "dddd, MMMM d, yyyy")
                color: Colors.textPrimary
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 12
                Layout.alignment: Qt.AlignHCenter
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Colors.borderSubtle
                Layout.margins: 4
            }

            Text {
                text: "hypr_bar status: active"
                color: Colors.textMuted
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 10
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}