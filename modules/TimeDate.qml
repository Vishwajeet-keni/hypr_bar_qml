import QtQuick
import QtQuick.Layouts
import "../config"

// Replaces widgets/bar/time_date_cal.yuck. Flat, no box - lives on the
// right side of the bar after MenuBar, not centered.
Item {
    id: root
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    RowLayout {
        id: row
        anchors.fill: parent
        spacing: 6

        Text {
            text: "\u{f0f56}"
            color: AppState.calendarOpen ? Colors.accentMauve : Colors.textSecondary
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 12
        }
        Text {
            id: clockText
            color: AppState.calendarOpen ? Colors.accentMauve : Colors.textPrimary
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 12
            font.bold: true
            text: Qt.formatDateTime(new Date(), "ddd dd-MMM hh:mm")
        }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: clockText.text = Qt.formatDateTime(new Date(), "ddd dd-MMM hh:mm")
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: AppState.calendarOpen = !AppState.calendarOpen
    }
}
