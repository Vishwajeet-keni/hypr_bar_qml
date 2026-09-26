import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import "../config"
import "../modules/bar"
import "../services"

PanelWindow {
    id: bar

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "hyprbar"
    exclusiveZone: Vars.barHeight

    anchors {
        top: true
        left: true
        right: true
    }

    margins { top: 3; left: 8; right: 8 }
    implicitHeight: Vars.barHeight
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 5
        color: Colors.barBg
        border.color: Colors.barBorder
        border.width: 1

        Item {                       // Main Container that alines its sub-containers row-wise

            anchors.fill: parent

            RowLayout {             // left sub-container
                id: leftContainer
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 8
                spacing: 8

                // Text { text: "Left"; color: "cyan"; font.pixelSize: 14 }
                DistroLogo {}
                Workspaces {}
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

                // Text { text: "Right"; color: "cyan"; font.pixelSize: 14 }
                SystemStats {}
                Updates {}
                Battery {}
                TimeDate {}
            }


        }    
    }
}