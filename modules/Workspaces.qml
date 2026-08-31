import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../config"

Rectangle {
    id: root
    implicitHeight: 28
    implicitWidth: wsRow.implicitWidth + 10
    radius: 7
    color: Colors.surfaceBg
    border.color: Colors.borderSubtle
    border.width: 1

    RowLayout {
        id: wsRow
        anchors.centerIn: parent
        spacing: 5

        Repeater {
            model: 6
            delegate: Rectangle {
                id: wsDot
                required property int index
                readonly property int wsId: index + 1
                readonly property bool isFocused: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === wsId
                
                width: isFocused ? 22 : 8
                height: 8
                radius: 4
                color: isFocused ? Colors.accentMauve : Colors.borderColor

                Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
                Behavior on color { ColorAnimation { duration: 150 } }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Hyprland.dispatch("workspace " + wsDot.wsId)
                }
            }
        }
    }
}