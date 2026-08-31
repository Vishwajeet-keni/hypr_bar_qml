import QtQuick

// Small shared state bucket, instantiated once in shell.qml and passed
// down to whichever components need it. Replaces the handful of global
// `defvar`/`deflisten` values from the eww config.
QtObject {
    property var batteryData: ({ icon: "", level: "100", class: "Full", status: "Full" })

    property bool controlPanelOpen: false
    property bool calendarOpen: false

    property bool lowBattVisible: false
    // Mirrors the /tmp/eww_batt_warning_shown flag from the original
    // battery.sh: makes sure we only pop the warning once per low-battery
    // episode instead of every time the poller ticks.
    property bool lowBattShown: false
}
