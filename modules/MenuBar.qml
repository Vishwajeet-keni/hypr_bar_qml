import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../config"

RowLayout {
    id: root
    spacing: 8

    Rectangle {
        width: 28
        height: 28
        radius: 7
        color: Colors.surfaceBg
        border.color: Colors.borderSubtle
        border.width: 1

        Text {
            anchors.centerIn: parent
            text: "󰣇"
            color: Colors.accentBlue
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 15
        }
    }

    Text {
        text: Hyprland.activeWindow ? (Hyprland.activeWindow.title || "") : ""
        color: Colors.textSecondary
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 11
        font.bold: true
        elide: Text.ElideRight
        Layout.maximumWidth: 260
        visible: text.length > 0
    }
}