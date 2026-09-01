import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "../config"
import "../components"
import "../services"

// Replaces widgets/control_center/control_center.yuck. This is the one
// part of the original design that *is* boxed/tiled (macOS Control Center
// style) - unlike the flat bar, that's intentional here.
PanelWindow {
    id: ccWindow

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "hyprbar-cc"

    visible: AppState.controlCenterOpen

    anchors { top: true; right: true }
    margins { top: 34; right: 8 }

    implicitWidth: 320
    implicitHeight: content.implicitHeight + 32
    color: "transparent"

    Process { id: actionExec }

    JsonPoller { id: wifiPoller; scriptPath: Paths.script("wifi.sh"); interval: 5000 }
    JsonPoller { id: btPoller; scriptPath: Paths.script("bluetooth.sh"); interval: 2000 }
    JsonPoller { id: pmPoller; scriptPath: Paths.script("power_mode.sh"); interval: 2000 }
    JsonPoller { id: volPoller; scriptPath: Paths.script("volume.sh"); interval: 2000 }
    JsonPoller { id: brightPoller; scriptPath: Paths.script("brightness.sh"); interval: 2000 }

    Rectangle {
        id: content
        anchors.fill: parent
        radius: 14
        color: Colors.bgGlass
        border.color: Colors.borderColor
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 8
                    ToggleTile {
                        Layout.fillWidth: true
                        label: "Wi-Fi"
                        icon: wifiPoller.data.icon || "\u{f05aa}"
                        sublabel: wifiPoller.data.status || ""
                        active: wifiPoller.data.state === "on"
                        activeColor: Colors.accentBlue
                        onClicked: wifiPoller.poll(["toggle"])
                    }
                    ToggleTile {
                        Layout.fillWidth: true
                        label: "Bluetooth"
                        icon: btPoller.data.icon || "\uf294"
                        sublabel: btPoller.data.status || ""
                        active: btPoller.data.state === "on"
                        activeColor: Colors.accentMauve
                        onClicked: btPoller.poll(["toggle"])
                    }
                    ToggleTile {
                        Layout.fillWidth: true
                        label: "Power Mode"
                        icon: pmPoller.data.icon || "\uf863"
                        sublabel: pmPoller.data.mode || ""
                        active: pmPoller.data.mode === "performance"
                        activeColor: Colors.accentPeach
                        onClicked: pmPoller.poll(["toggle"])
                    }
                }

                // Placeholders - Stage Manager / Screen Mirroring have no
                // direct Linux equivalent, matching the original.
                ColumnLayout {
                    spacing: 8
                    IconTile { icon: "\uf2d2" }
                    IconTile { icon: "\uf26c" }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 6

                GlassSlider {
                    Layout.fillWidth: true
                    icon: "\u{f00db}"
                    accentColor: Colors.accentYellow
                    value: brightPoller.data.value !== undefined ? brightPoller.data.value : 50
                    onSliderMoved: val => {
                        actionExec.command = [Paths.script("brightness.sh"), "set", String(Math.round(val))]
                        actionExec.running = true
                    }
                }
                GlassSlider {
                    Layout.fillWidth: true
                    icon: "\u{f057e}"
                    accentColor: Colors.accentBlue
                    value: volPoller.data.value !== undefined ? volPoller.data.value : 50
                    onSliderMoved: val => {
                        actionExec.command = [Paths.script("volume.sh"), "set", String(Math.round(val))]
                        actionExec.running = true
                    }
                }
            }
        }
    }
}
