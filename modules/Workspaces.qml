import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

// Replaces widgets/bar/workspace.yuck + scripts/workspaces.sh.
// Quickshell talks to Hyprland's IPC socket directly, so there's no need
// for the socat/hyprctl polling script anymore - workspace changes show up
// here immediately and `hyprctl dispatch` isn't needed either.
RowLayout {
    id: root
    property var pal
    spacing: 1

    Repeater {
        // Hyprland.workspaces is a live ObjectModel; Repeater updates
        // automatically as workspaces are created/destroyed.
        model: Hyprland.workspaces

        delegate: Item {
            id: wsBtn
            required property var modelData
            readonly property bool active: modelData.focused

            implicitWidth: label.implicitWidth + 10
            implicitHeight: label.implicitHeight + 2

            Text {
                id: label
                anchors.centerIn: parent
                text: wsBtn.active ? "\u25cf" : String(wsBtn.modelData.id)
                color: wsBtn.active ? root.pal.mauve : (ma.containsMouse ? root.pal.mauve : root.pal.textPrimary)
                font.pixelSize: wsBtn.active ? 11 : 13
                font.bold: true
            }

            MouseArea {
                id: ma
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: wsBtn.modelData.activate()
            }
        }
    }
}
