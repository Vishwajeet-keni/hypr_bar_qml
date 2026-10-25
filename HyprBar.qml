import QtQuick
import Quickshell

import "windows"

Scope {
    id: root

    Bar { id: bar }
    LowBattWarning {}
    CalendarPopup { anchorWindow: bar }
}