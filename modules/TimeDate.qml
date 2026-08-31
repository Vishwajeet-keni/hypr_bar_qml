import QtQuick
import QtQuick.Layouts
import Quickshell
import "../config"

Rectangle {
    id: root
    implicitWidth: timeRow.implicitWidth + 16
    implicitHeight: 28
    radius: 7
    color: AppState.calendarOpen ? Qt.rgba(Colors.accentMauve.r, Colors.accentMauve.g, Colors.accentMauve.b, 0.25) : Colors.surfaceBg
    border.color: AppState.calendarOpen ? Colors.accentMauve : Colors.borderSubtle
    border.width: 1

    Behavior on color { ColorAnimation { duration: 150 } }

    RowLayout {
        id: timeRow
        anchors.centerIn: parent
        spacing: 6

        Text {
            text: "󰥔"
            color: Colors.accentMauve
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 13
        }

        Text {
            id: clockText
            color: Colors.textPrimary
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 11
            font.bold: true
            text: Qt.formatDateTime(new Date(), "ddd dd MMM  hh:mm A")
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clockText.text = Qt.formatDateTime(new Date(), "ddd dd MMM  hh:mm A")
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: AppState.calendarOpen = !AppState.calendarOpen
    }
}