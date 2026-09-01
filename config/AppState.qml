pragma Singleton
import QtQuick

// Shared UI state. Wifi/bluetooth/power-mode ON-OFF state is NOT kept here -
// each script's own JSON output is the single source of truth for that, so
// the UI can't drift out of sync with what the system actually did.
QtObject {
    property bool controlCenterOpen: false
    property bool calendarOpen: false

    // Makes sure the low battery dialog only pops once per low-battery
    // episode instead of every time the poller ticks.
    property bool lowBattDismissed: false
}
