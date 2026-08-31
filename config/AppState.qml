pragma Singleton
import QtQuick

QtObject {
    property bool controlCenterOpen: false
    property bool calendarOpen: false
    property bool wifiEnabled: true
    property bool bluetoothEnabled: true
    property bool dndEnabled: false
    property bool nightLightEnabled: false
    property string activePowerProfile: "balanced"
}