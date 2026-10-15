pragma Singleton
import QtQuick

QtObject {
    id: state

    property bool menuOpen: false
    property bool calendarOpen: false

    function openCalendar() {
        calendarCloseTimer.stop()
        calendarOpen = true
    }

    function toggleCalendar() {
        calendarCloseTimer.stop()
        calendarOpen = !calendarOpen
    }

    function scheduleCalendarClose() {
        calendarCloseTimer.restart()
    }

    function cancelCalendarClose() {
        calendarCloseTimer.stop()
    }

    property var calendarCloseTimer: Timer {
        interval: 500
        repeat: false
        onTriggered: state.calendarOpen = false
    }

    property bool lowBattVisible: false
    property bool lowBattShown: false
}