import Quickshell.Io
import QtQuick

// Replaces widgets/bar/time_date_cal.yuck. Uses `date` directly instead of
// a defpoll script since the original command was a one-liner anyway.
Item {
    id: root
    property var pal
    property var state
    property string timeText: "--:-- --"

    implicitWidth: label.implicitWidth + 10
    implicitHeight: label.implicitHeight

    Process {
        id: dateProc
        command: ["date", "+%a %d-%b %H:%M"]
        stdout: StdioCollector { onStreamFinished: root.timeText = this.text.trim() }
    }
    Component.onCompleted: dateProc.running = true
    Timer { interval: 10000; running: true; repeat: true; onTriggered: dateProc.running = true }

    Text {
        id: label
        anchors.centerIn: parent
        text: root.timeText
        color: root.pal.textPrimary
        font.pixelSize: 13
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.state.calendarOpen = true
        onExited: calCloseTimer.restart()
        onEntered: calCloseTimer.stop()
    }
    Timer { id: calCloseTimer; interval: 300; onTriggered: root.state.calendarOpen = false }
}
