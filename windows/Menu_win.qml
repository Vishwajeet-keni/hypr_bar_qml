import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland

import "../config"

PanelWindow{
    id: menu
    anchor { top: true; right: true; }
    visible: AppState.menuOpen
    color: "transparent"


    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: AppState. = true
        onExited: closeTimer.restart()
        onEntered: closeTimer.stop()
    }

    Timer {
        id: closeTimer
        interval: 300
        onTriggered: AppState.calendarOpen = false
    }
}