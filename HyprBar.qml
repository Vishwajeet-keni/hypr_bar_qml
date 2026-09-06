import Quickshell
import Quickshell.Wayland
import QtQuick

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
    }
}