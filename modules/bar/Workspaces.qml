import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Io
import "../../config"

RowLayout {
    id: root
    spacing: 2

    readonly property var defaultIds: [1, 2, 3, 4, 5]

    readonly property var ids: {
        const existing = Hyprland.workspaces.values.map(w => w.id)
        return [...new Set(root.defaultIds.concat(existing))].sort((a, b) => a - b)
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            const name = `${event?.name ?? event?.event ?? event?.type ?? ""}`
            if (name === "workspace" || name === "createworkspace" || name === "destroyworkspace")
                root.idsChanged()
        }
    }

    function findWorkspace(id) {
        return Hyprland.workspaces.values.find(w => w.id === id)
    }

    function switchTo(id) {
        if (Hyprland.usingLua)
            Hyprland.dispatch(`hl.dsp.focus({workspace = '${id}'})`)
        else
            Hyprland.dispatch(`workspace ${id}`)
    }

    Repeater {
        model: root.ids
        delegate: Item {
            id: wsBtn
            required property int modelData
            readonly property var ws: root.findWorkspace(modelData)
            readonly property bool active: !!ws && ws.focused

            implicitWidth: Math.max(Vars.btnSize - 3, label.implicitWidth + Vars.padWsBtn * 2)
            implicitHeight: Math.max(Vars.btnSize, label.implicitHeight + Vars.padWsBtn * 2)

            Text {
                id: label
                anchors.centerIn: parent
                text: wsBtn.active ? "\u25cf" : String(wsBtn.modelData)
                color: wsBtn.active ? Colors.accentMauve : (ma.containsMouse ? Colors.accentMauve : Colors.textPrimary)
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: wsBtn.active ? Vars.fontSm : (ma.containsMouse ? Vars.fontBase + 2 : Vars.fontBase)
                font.bold: !wsBtn.active
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