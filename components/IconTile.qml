import QtQuick
import QtQuick.Layouts

// Replaces the cc-icon-tile reusable widget from tiles.yuck (used for the
// Stage/Mirror placeholders, which have no direct Linux equivalent).
Rectangle {
    id: tile
    property var pal
    property string icon: ""
    property string title: ""
    implicitWidth: 64
    implicitHeight: 64
    radius: 12
    color: Qt.rgba(1, 1, 1, 0.06)

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 4
        Text { text: tile.icon; color: tile.pal.textPrimary; font.pixelSize: 18; Layout.alignment: Qt.AlignHCenter }
        Text { text: tile.title; color: tile.pal.textPrimary; font.pixelSize: 9; Layout.alignment: Qt.AlignHCenter }
    }
}
