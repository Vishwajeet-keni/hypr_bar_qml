import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../config"

// Replaces the hypr_bar defwindow + its centerbox layout.
// One shared translucent background for the whole bar - individual
// widgets are flat text/icons, not their own boxes (that boxed look
// belongs to the Control Center, see ControlCenter.qml).
PanelWindow {
    id: barRoot

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "hyprbar"
    exclusiveZone: 30

    anchors {
        top: true
        left: true
        right: true
    }
    margins { top: 3; left: 6; right: 6 }
    implicitHeight: 26
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 5
        color: Colors.barBg
        border.color: Colors.barBorder
        border.width: 1

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            spacing: 10

            // ── Left: Arch logo + workspaces ──
            RowLayout {
                Layout.alignment: Qt.AlignVCenter
                spacing: 10
                ArchLogo {}
                Workspaces {}
            }

            // ── Center: empty spacer ──
            Item { Layout.fillWidth: true }

            // ── Right: system stats, menu, clock ──
            RowLayout {
                Layout.alignment: Qt.AlignVCenter
                spacing: 8
                SystemStats {}
                MenuBar {}
                TimeDate {}
            }
        }
    }
}
