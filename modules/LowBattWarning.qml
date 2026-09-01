import QtQuick
import QtQuick.Layouts
import Quickshell
import "../config"
import "../services"

// Replaces the `low_batt_warning` eww window - a standalone floating
// dialog (not anchored to the bar), matching the original's
// `:windowtype "dialog"` + centered geometry.
//
// Hyprland note: since this spawns as a normal floating toplevel, you may
// want a window rule to keep it centered, e.g. in hyprland.conf:
//   windowrulev2 = float, title:^(Low Battery Warning)$
//   windowrulev2 = center, title:^(Low Battery Warning)$
FloatingWindow {
    id: popup

    title: "Low Battery Warning"
    implicitWidth: 260
    implicitHeight: 130
    color: "transparent"

    JsonPoller {
        id: battPoller
        scriptPath: Paths.script("battery.sh")
        interval: 15000
    }

    readonly property int level: parseInt(battPoller.data.level, 10)
    readonly property bool critical: battPoller.data.status === "Discharging"
        && !isNaN(level) && level <= 30

    // Reset the dismiss-flag once we're no longer critical, so the next
    // low-battery episode pops the dialog again.
    onCriticalChanged: if (!critical) AppState.lowBattDismissed = false

    visible: critical && !AppState.lowBattDismissed

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: Qt.rgba(Colors.accentRed.r, Colors.accentRed.g, Colors.accentRed.b, 0.95)
        border.color: Colors.textPrimary
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 8

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10
                Text { text: "\u{f008e}"; color: "#ffffff"; font.family: "JetBrains Mono Nerd Font"; font.pixelSize: 22 }
                Text {
                    text: "Battery is low!"
                    color: "#ffffff"
                    font.family: "JetBrains Mono Nerd Font"
                    font.bold: true
                    font.pixelSize: 15
                }
            }
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Please connect to charger (" + (isNaN(popup.level) ? "?" : popup.level) + "%)"
                color: "#f5c2e7"
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 11
            }
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: okLabel.implicitWidth + 28
                implicitHeight: okLabel.implicitHeight + 8
                radius: 4
                color: okMa.containsMouse ? Qt.rgba(1, 1, 1, 0.15) : Qt.rgba(1, 1, 1, 0.05)
                border.width: 1
                border.color: "#ffffff"
                Text {
                    id: okLabel
                    anchors.centerIn: parent
                    text: "OK"
                    color: "#ffffff"
                    font.family: "JetBrains Mono Nerd Font"
                }
                MouseArea {
                    id: okMa
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: AppState.lowBattDismissed = true
                }
            }
        }
    }
}
