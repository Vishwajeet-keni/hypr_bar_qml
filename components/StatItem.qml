import QtQuick
import QtQuick.Layouts
import "../config"

// Flat icon+label pair, no box - matches the bar's shared-background look.
// (Boxed tiles belong in the Control Center, not the bar - see ToggleTile.)
RowLayout {
    property string icon: ""
    property string label: ""
    property color highlightColor: Colors.accentBlue
    spacing: 5

    Text {
        text: icon
        color: highlightColor
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 13
    }
    Text {
        text: label
        color: highlightColor
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 12
        font.bold: true
    }
}
