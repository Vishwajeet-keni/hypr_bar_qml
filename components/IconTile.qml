import QtQuick
import "../config"

Rectangle {
    id: root
    property string icon: ""
    property color iconColor: Colors.textPrimary
    property color bgColor: Colors.surfaceBg
    signal clicked()

    implicitWidth: 34
    implicitHeight: 34
    radius: 8
    color: mouseArea.containsMouse ? Colors.surfaceBgHover : root.bgColor
    border.color: Colors.borderSubtle
    border.width: 1

    Behavior on color { ColorAnimation { duration: 120 } }

    Text {
        anchors.centerIn: parent
        text: root.icon
        color: root.iconColor
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 14
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}