import Quickshell
import QtQuick
import QtQuick.Layouts

// Replaces widgets/control_center/control_center.yuck. Anchored to the
// bar's top-right corner, same as the original `:anchor "top right"`
// eww window geometry.
PopupWindow {
    id: popup
    property var pal
    property var state

    implicitWidth: 320
    implicitHeight: content.implicitHeight + 32
    visible: state.controlPanelOpen
    color: "transparent"

    JsonPoller { id: wifiPoller; script: "$HOME/.config/quickshell/scripts/wifi.sh"; interval: 5000 }
    JsonPoller { id: btPoller; script: "$HOME/.config/quickshell/scripts/bluetooth.sh"; interval: 2000 }
    JsonPoller { id: pmPoller; script: "$HOME/.config/quickshell/scripts/power_mode.sh"; interval: 2000 }
    JsonPoller { id: brightPoller; script: "$HOME/.config/quickshell/scripts/brightness.sh"; interval: 2000 }
    JsonPoller { id: volPoller; script: "$HOME/.config/quickshell/scripts/volume.sh"; interval: 2000 }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onExited: closeTimer.restart()
        onEntered: closeTimer.stop()

        Rectangle {
            id: content
            anchors.fill: parent
            anchors.margins: 8
            radius: 14
            color: Qt.rgba(1, 1, 1, 0.06)
            border.width: 1
            border.color: Qt.rgba(1, 1, 1, 0.14)

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 12

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 6
                        ToggleTile {
                            pal: popup.pal
                            icon: wifiPoller.data.icon || "\u{f05aa}"
                            title: "Wi-Fi"
                            subtitle: wifiPoller.data.status || ""
                            onActivated: wifiPoller.poll(["toggle"])
                        }
                        ToggleTile {
                            pal: popup.pal
                            icon: btPoller.data.icon || "\uf294"
                            title: "Bluetooth"
                            subtitle: btPoller.data.status || ""
                            onActivated: btPoller.poll(["toggle"])
                        }
                        ToggleTile {
                            pal: popup.pal
                            icon: pmPoller.data.icon || "\uf863"
                            title: "Power Mode"
                            subtitle: pmPoller.data.mode || ""
                            onActivated: pmPoller.poll(["toggle"])
                        }
                    }

                    // Placeholders - Stage Manager / Screen Mirroring have
                    // no direct Linux equivalent, same as the eww version.
                    RowLayout {
                        spacing: 6
                        IconTile { pal: popup.pal; icon: "\uf2d2"; title: "Stage" }
                        IconTile { pal: popup.pal; icon: "\uf26c"; title: "Mirror" }
                    }
                }

                GlassSlider {
                    pal: popup.pal
                    Layout.fillWidth: true
                    label: "Display"
                    from: 1
                    to: 100
                    value: brightPoller.data.value !== undefined ? brightPoller.data.value : 50
                    onMoved: v => brightPoller.poll(["set", Math.round(v)])
                }
                GlassSlider {
                    pal: popup.pal
                    Layout.fillWidth: true
                    label: "Sound"
                    from: 0
                    to: 100
                    value: volPoller.data.value !== undefined ? volPoller.data.value : 50
                    onMoved: v => volPoller.poll(["set", Math.round(v)])
                }
            }
        }
    }

    Timer { id: closeTimer; interval: 300; onTriggered: popup.state.controlPanelOpen = false }
}
