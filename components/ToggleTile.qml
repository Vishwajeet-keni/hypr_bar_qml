import QtQuick
import QtQuick.Layouts

// Replaces the cc-toggle-tile reusable widget from tiles.yuck.
Rectangle {
    id: tile
    property var pal
    property string icon: ""
    property string title: ""
    property string subtitle: ""
    signal activated()

    Layout.fillWidth: true
    implicitHeight: 42
    radius: 10
    color: ma.containsMouse ? Qt.rgba(1, 1, 1, 0.06) : "transparent"

    RowLayout {
        anchors.fill: parent
        anchors.margins: 6
        spacing: 10

        Rectangle {
            width: 26
            height: 26
            radius: 8
            color: tile.pal.blue
            Text {
                anchors.centerIn: parent
                text: tile.icon
                color: tile.pal.bgDark
                font.pixelSize: 14
            }
        }
        ColumnLayout {
            spacing: 0
            Text { text: tile.title; color: tile.pal.textPrimary; font.pixelSize: 13; font.bold: true }
            Text { text: tile.subtitle; color: tile.pal.textMuted; font.pixelSize: 10 }
        }
        Item { Layout.fillWidth: true }
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: tile.activated()
    }
}
