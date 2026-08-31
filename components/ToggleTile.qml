import QtQuick
import QtQuick.Layouts
import "../config"

Rectangle {
    id: root
    property string icon: ""
    property string label: ""
    property string sublabel: ""
    property bool active: false
    property color activeColor: Colors.accentBlue
    signal clicked()

    height: 52
    radius: 10
    color: active ? Qt.rgba(activeColor.r, activeColor.g, activeColor.b, 0.2) : Colors.surfaceBg
    border.color: active ? activeColor : Colors.borderSubtle
    border.width: 1

    Behavior on color { ColorAnimation { duration: 150 } }
    Behavior on border.color { ColorAnimation { duration: 150 } }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Rectangle {
            width: 32
            height: 32
            radius: 8
            color: root.active ? root.activeColor : Colors.activeBg

            Behavior on color { ColorAnimation { duration: 150 } }

            Text {
                anchors.centerIn: parent
                text: root.icon
                color: root.active ? Colors.bgGlass : Colors.textPrimary
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 15
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 1

            Text {
                text: root.label
                color: Colors.textPrimary
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 12
                font.bold: true
            }

            Text {
                text: root.sublabel !== "" ? root.sublabel : (root.active ? "On" : "Off")
                color: Colors.textMuted
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 10
                visible: text.length > 0
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}