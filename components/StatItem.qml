import QtQuick
import QtQuick.Layouts
import "../config"

Rectangle {
    id: root
    property string icon: ""
    property string label: ""
    property color highlightColor: Colors.accentBlue
    property bool alert: false

    implicitWidth: contentRow.implicitWidth + 16
    implicitHeight: 28
    radius: 7
    color: alert ? Qt.rgba(Colors.accentRed.r, Colors.accentRed.g, Colors.accentRed.b, 0.25) : Colors.surfaceBg
    border.color: alert ? Colors.accentRed : Colors.borderSubtle
    border.width: 1

    Behavior on color { ColorAnimation { duration: 150 } }

    RowLayout {
        id: contentRow
        anchors.centerIn: parent
        spacing: 5

        Text {
            text: root.icon
            color: root.alert ? Colors.accentRed : root.highlightColor
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 13
        }

        Text {
            text: root.label
            color: root.alert ? Colors.accentRed : Colors.textPrimary
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 11
            font.bold: true
        }
    }
}