import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "../config"
import "../components"
import "../services"

PanelWindow {
    id: ccWindow

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "hyprbar-cc"

    visible: AppState.controlCenterOpen

    anchors {
        top: true
        right: true
    }
    margins {
        top: 42
        right: 12
    }

    width: 340
    height: 380
    color: "transparent"

    Process { id: actionExec }

    JsonPoller {
        id: volPoller
        scriptPath: Quickshell.shellPath("hypr_bar_qml/scripts/volume.sh")
        interval: 1000
    }

    JsonPoller {
        id: brightPoller
        scriptPath: Quickshell.shellPath("hypr_bar_qml/scripts/brightness.sh")
        interval: 2000
    }

    Rectangle {
        anchors.fill: parent
        radius: 14
        color: Colors.bgGlass
        border.color: Colors.borderColor
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            // Header Section
            RowLayout {
                Layout.fillWidth: true

                Text {
                    text: "Quick Controls"
                    color: Colors.textPrimary
                    font.family: "JetBrains Mono Nerd Font"
                    font.bold: true
                    font.pixelSize: 14
                }

                Item { Layout.fillWidth: true }

                IconTile {
                    icon: "󰐥"
                    iconColor: Colors.accentRed
                    onClicked: {
                        actionExec.command = ["wlogout"]
                        actionExec.running = true
                    }
                }
            }

            // Quick Toggles Grid
            GridLayout {
                columns: 2
                Layout.fillWidth: true
                columnSpacing: 8
                rowSpacing: 8

                ToggleTile {
                    label: "Wi-Fi"
                    icon: "󰖩"
                    active: AppState.wifiEnabled
                    activeColor: Colors.accentBlue
                    Layout.fillWidth: true
                    onClicked: {
                        AppState.wifiEnabled = !AppState.wifiEnabled
                        actionExec.command = ["sh", Quickshell.shellPath("hypr_bar_qml/scripts/wifi.sh"), "toggle"]
                        actionExec.running = true
                    }
                }

                ToggleTile {
                    label: "Bluetooth"
                    icon: "󰂯"
                    active: AppState.bluetoothEnabled
                    activeColor: Colors.accentMauve
                    Layout.fillWidth: true
                    onClicked: {
                        AppState.bluetoothEnabled = !AppState.bluetoothEnabled
                        actionExec.command = ["sh", Quickshell.shellPath("hypr_bar_qml/scripts/bluetooth.sh"), "toggle"]
                        actionExec.running = true
                    }
                }

                ToggleTile {
                    label: "Night Light"
                    icon: "󱩌"
                    active: AppState.nightLightEnabled
                    activeColor: Colors.accentPeach
                    Layout.fillWidth: true
                    onClicked: AppState.nightLightEnabled = !AppState.nightLightEnabled
                }

                ToggleTile {
                    label: "Do Not Disturb"
                    icon: "󰂛"
                    active: AppState.dndEnabled
                    activeColor: Colors.accentRed
                    Layout.fillWidth: true
                    onClicked: AppState.dndEnabled = !AppState.dndEnabled
                }
            }

            // Sliders Section
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 6

                GlassSlider {
                    Layout.fillWidth: true
                    icon: "󰕾"
                    accentColor: Colors.accentBlue
                    value: (volPoller.data && volPoller.data.volume !== undefined) ? volPoller.data.volume : 50
                    onSliderMoved: val => {
                        actionExec.command = ["sh", Quickshell.shellPath("hypr_bar_qml/scripts/volume.sh"), "--set", Math.round(val)]
                        actionExec.running = true
                    }
                }

                GlassSlider {
                    Layout.fillWidth: true
                    icon: "󰃠"
                    accentColor: Colors.accentYellow
                    value: (brightPoller.data && brightPoller.data.brightness !== undefined) ? brightPoller.data.brightness : 50
                    onSliderMoved: val => {
                        actionExec.command = ["sh", Quickshell.shellPath("hypr_bar_qml/scripts/brightness.sh"), "--set", Math.round(val)]
                        actionExec.running = true
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }
    }
}