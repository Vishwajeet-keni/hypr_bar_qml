import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Io
import "../config"

// Replaces widgets/bar/workspace.yuck + scripts/workspaces.sh (native
// Hyprland IPC replaces the old socat-based script). Flat plain-number
// indicators, matching the original - not boxed dot pills.
RowLayout {
    id: root
    spacing: 2

    // Always show at least these, even when empty - matches the original
    // workspaces.sh's `all_workspaces="1 2 3 4 5 $workspaces"`.
    property var defaultIds: [1, 2, 3, 4, 5]

    // Hyprland.workspaces is a live ObjectModel; a plain binding that reads
    // `.values` once doesn't reliably re-run on add/remove, so nudge a
    // recompute once a second (cheap, matches the original script's own
    // polling fallback).
    property int _tick: 0
    Timer { interval: 1000; running: true; repeat: true; onTriggered: root._tick++ }

    readonly property var ids: {
        root._tick // dependency only
        const existing = Hyprland.workspaces.values.map(w => w.id)
        return [...new Set(root.defaultIds.concat(existing))].sort((a, b) => a - b)
    }

    function findWorkspace(id) {
        return Hyprland.workspaces.values.find(w => w.id === id)
    }

    // hyprctl's own dispatcher handles lua vs. non-lua Hyprland configs
    // correctly; Quickshell's Hyprland.dispatch()/activate() does not
    // always (seen as "')' expected near '2'" under lua-mode configs).
    // Shelling to `hyprctl` also lets us switch to a default slot (1-5)
    // that hasn't been created yet.
    Process { id: switchProc }
    function switchTo(id) {
        switchProc.command = ["hyprctl", "dispatch", "workspace", String(id)]
        switchProc.running = true
    }

    Repeater {
        model: root.ids

        delegate: Item {
            id: wsBtn
            required property int modelData
            readonly property var ws: root.findWorkspace(modelData)
            readonly property bool active: !!ws && ws.focused

            implicitWidth: label.implicitWidth + 8
            implicitHeight: label.implicitHeight

            Text {
                id: label
                anchors.centerIn: parent
                text: wsBtn.active ? "\u25cf" : String(wsBtn.modelData)
                color: wsBtn.active ? Colors.accentMauve : (ma.containsMouse ? Colors.accentMauve : Colors.textSecondary)
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: wsBtn.active ? 11 : 13
                font.bold: true
            }

            MouseArea {
                id: ma
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.switchTo(wsBtn.modelData)
            }
        }
    }
}
