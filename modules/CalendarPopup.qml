import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../config"

// Replaces the `cal_popup` eww window (a GTK calendar bound to EWW_TIME).
// QML has no built-in GTK-style calendar, so this draws a month grid
// instead, with today highlighted. Anchored top-right, near the clock.
PanelWindow {
    id: calWindow

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "hyprbar-cal"

    visible: AppState.calendarOpen

    anchors { top: true; right: true }
    margins { top: 34; right: 8 }

    implicitWidth: 220
    implicitHeight: 220
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: Colors.bgGlass
        border.color: Colors.borderColor
        border.width: 1

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onExited: AppState.calendarOpen = false
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: Qt.formatDate(new Date(), "MMMM yyyy")
                color: Colors.textPrimary
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 14
                font.bold: true
            }

            GridLayout {
                columns: 7
                rowSpacing: 4
                columnSpacing: 4
                Layout.fillWidth: true

                Repeater {
                    model: ["S", "M", "T", "W", "T", "F", "S"]
                    delegate: Text {
                        required property string modelData
                        text: modelData
                        color: Colors.textMuted
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 10
                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                Repeater {
                    model: {
                        const now = new Date()
                        const first = new Date(now.getFullYear(), now.getMonth(), 1)
                        const startOffset = first.getDay()
                        const daysInMonth = new Date(now.getFullYear(), now.getMonth() + 1, 0).getDate()
                        const cells = []
                        for (let i = 0; i < startOffset; i++) cells.push("")
                        for (let d = 1; d <= daysInMonth; d++) cells.push(d)
                        return cells
                    }
                    delegate: Text {
                        required property var modelData
                        readonly property int today: new Date().getDate()
                        text: modelData !== "" ? String(modelData) : ""
                        color: modelData === today ? Colors.accentMauve : Colors.textPrimary
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 11
                        font.bold: modelData === today
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }
        }
    }
}
