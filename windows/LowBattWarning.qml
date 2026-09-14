import QtQuick
import QtQuick.Layouts
import Quickshell
import "../config"

FloatingWindow {
    id: popup
    title: "Low Battery Warning"
    visible: AppState.lowBattVisible
    implicitWidth: 260
    implicitHeight: 150
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 5
        color: Qt.rgba(0, 0, 0, 0.85)
        border.color: "whitesmoke"
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 12

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "\uf244"
                color: "red"
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 28
            }
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Battery is low!"
                color: "whitesmoke"
                font.pixelSize: 15
                font.bold: true
            }
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Please connect to charger"
                color: "#aaaaaa"
                font.pixelSize: 12
            }
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: okLabel.implicitWidth + 32
                implicitHeight: okLabel.implicitHeight + 8
                radius: 5
                color: okMa.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent"
                border.color: "whitesmoke"
                border.width: 1
                Text {
                    id: okLabel
                    anchors.centerIn: parent
                    text: "OK"
                    color: "whitesmoke"
                }
                MouseArea {
                    id: okMa
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: AppState.lowBattVisible = false
                }
            }
        }
    }
}