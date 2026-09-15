import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../config"

PanelWindow {
    id: anchorWin
    anchors { top: true; left: true; right: true; bottom: true }
    visible: AppState.lowBattVisible
    color: "transparent"
    exclusiveZone: 0
    WlrLayershell.layer: WlrLayer.Overlay

    MouseArea {
        anchors.fill: parent
        onClicked: AppState.lowBattVisible = false
    }

    PopupWindow {
        id: popup
        anchor.window: anchorWin
        anchor.rect.x: anchorWin.width / 2 - implicitWidth / 2
        anchor.rect.y: anchorWin.height / 2 - implicitHeight / 2
        implicitWidth: content.implicitWidth + 40
        implicitHeight: content.implicitHeight + 40
        visible: AppState.lowBattVisible
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            radius: 5
            color: Qt.rgba(0, 0, 0, 0.85)
            border.color: "whitesmoke"
            border.width: 1

            ColumnLayout {
                id: content
                anchors.centerIn: parent   // was anchors.fill + margins: 20
                spacing: 12

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "\uf243"
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
}