import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

// Replaces the `hypr_bar` defwindow + its centerbox layout.
PanelWindow {
    id: bar
    property var pal
    property var state

    screen: Quickshell.screens[0] // eww's `:monitor 0`
    anchors { top: true; left: true; right: true }
    margins { top: 3; left: 6; right: 6 }
    implicitHeight: 26
    exclusiveZone: implicitHeight + 3 // eww's `:exclusive "true"`
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "hypr_bar"

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.5)   // .base_div background
        radius: 5
        border.width: 1
        border.color: Qt.rgba(0.96, 0.96, 0.96, 1) // whitesmoke

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            spacing: 10

            // ── Left: Arch logo + workspaces ──
            RowLayout {
                Layout.alignment: Qt.AlignVCenter
                spacing: 10
                Text {
                    text: "\uf303" // nf-linux-archlinux
                    color: bar.pal.archBlue
                    font.pixelSize: 18
                    font.bold: true
                }
                Workspaces { pal: bar.pal }
            }

            // ── Center: empty spacer, matches the eww centerbox's blank center ──
            Item { Layout.fillWidth: true }

            // ── Right: system stats, menu, clock ──
            RowLayout {
                Layout.alignment: Qt.AlignVCenter
                spacing: 8
                SystemStats { pal: bar.pal }
                MenuBar { pal: bar.pal; state: bar.state }
                TimeDate { pal: bar.pal; state: bar.state }
            }
        }
    }
}
