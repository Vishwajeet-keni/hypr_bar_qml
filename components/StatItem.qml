import QtQuick
import QtQuick.Layouts

// Replaces the reusable `status_item` eww widget.
RowLayout {
    property var pal
    property string icon: ""
    property string label: ""
    property string state: ""
    spacing: 6

    Text {
        text: icon
        color: pal ? pal.stateColor(state) : "white"
        font.pixelSize: 13
    }
    Text {
        text: label
        color: pal ? pal.stateColor(state) : "white"
        font.pixelSize: 13
        font.bold: true
    }
}
