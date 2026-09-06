import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: bar

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "hyprbar"
    exclusiveZone: 30

    anchors {
        top: true
        left: true
        right: true
    }

    margins { top: 3; left: 8; right: 8 }
    implicitHeight: 30
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 5
        color: Qt.rgba(0, 0, 0, 0.5)
        border.color: "whitesmoke"
        border.width: 1


        RowLayout {                     // Main Container that alines its sub-containers row-wise
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            spacing: 10


            Item {

                anchors.fill: parent

                RowLayout {             // left sub-container
                    id: leftContainer
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 8
                    spacing: 10

                    Text { text: "Left"; color: "cyan"; font.pixelSize: 14 }
                }

                RowLayout {             // center sub-container
                    id: centerContainer
                    anchors.centerIn: parent
                    spacing: 10

                    Text { text: "Center"; color: "cyan"; font.pixelSize: 14 }
                }

                RowLayout {             // right sub-container
                    id: rightContainer
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 8
                    spacing: 8

                    Text { text: "Right"; color: "cyan"; font.pixelSize: 14 }
                }


            }
        }
    }
}