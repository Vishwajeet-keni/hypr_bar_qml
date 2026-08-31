import Quickshell
import QtQuick
import QtQuick.Layouts

// Replaces the `low_batt_warning` eww window/widget. A standalone floating
// dialog (not anchored to the bar), matching the original's
// `:windowtype "dialog"` + centered geometry.
//
// Hyprland note: since this spawns as a normal floating toplevel, you may
// want a window rule to keep it centered, e.g. in hyprland.conf:
//   windowrulev2 = float, title:^(Low Battery Warning)$
//   windowrulev2 = center, title:^(Low Battery Warning)$
FloatingWindow {
    id: popup
    property var pal
    property var state

    title: "Low Battery Warning"
    visible: state.lowBattVisible
    implicitWidth: 240
    implicitHeight: 130
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 6
        color: Qt.rgba(0, 0, 0, 0.85)
        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 1)

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 8

            Text {
                text: "Battery is low!"
                color: "whitesmoke"
                font.pixelSize: 15
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }
            Text {
                text: "Please connect to charger"
                color: "#aaaaaa"
                font.pixelSize: 12
                Layout.alignment: Qt.AlignHCenter
            }
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: okLabel.implicitWidth + 32
                implicitHeight: okLabel.implicitHeight + 8
                radius: 4
                color: okMa.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent"
                border.width: 1
                border.color: "whitesmoke"
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
                    onClicked: popup.state.lowBattVisible = false
                }
            }
        }
    }
}
