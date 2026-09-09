import QtQuick
import QtQuick.Layouts
import "../../config"

Item {
    id: root
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    // implicitWidth: Math.max(Vars.btnSize, label.implicitWidth)
    // implicitHeight: Math.max(Vars.fontBase, label.implicitHeight)
    Text {
        id: label
        anchors.fill: parent
        color: AppState.calendarOpen ? Colors.accentMauve : Colors.textPrimary
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: Vars.fontBase
        font.bold: true
        text: Qt.formatDateTime(new Date(), "ddd dd-MMM hh:mm")
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: label.text = Qt.formatDateTime(new Date(), "ddd dd-MMM hh:mm")
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: AppState.calendarOpen = true
        onExited: closeTimer.restart()
        onEntered: closeTimer.stop()
    }

    Timer {
        id: closeTimer
        interval: 300
        onTriggered: AppState.calendarOpen = false
    }
}