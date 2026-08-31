import Quickshell
import QtQuick
import QtQuick.Layouts

// Replaces the `cal_popup` eww window (a GTK calendar bound to EWW_TIME).
// QML has no built-in GTK-style calendar widget, so this draws a simple
// month grid instead, with today highlighted.
PopupWindow {
    id: popup
    property var pal
    property var state

    implicitWidth: 220
    implicitHeight: 220
    visible: state.calendarOpen
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: Qt.rgba(0, 0, 0, 0.6)
        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 0.8)

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onExited: popup.state.calendarOpen = false
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: Qt.formatDate(new Date(), "MMMM yyyy")
                color: popup.pal.textPrimary
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
                        color: popup.pal.textMuted
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
                        color: modelData === today ? popup.pal.mauve : popup.pal.textPrimary
                        font.pixelSize: 11
                        font.bold: modelData === today
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }
        }
    }
}
