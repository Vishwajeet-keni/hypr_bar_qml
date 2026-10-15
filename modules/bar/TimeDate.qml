import QtQuick
import QtQuick.Layouts

import "../../config"

Item {
    id: root
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

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

    HoverHandler {
        onHoveredChanged: {
            if (hovered) {
                AppState.cancelCalendarClose()
            } else {
                AppState.scheduleCalendarClose()
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: AppState.toggleCalendar()
    }
}