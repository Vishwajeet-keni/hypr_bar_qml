import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../config"

RowLayout {
    id: root
    property string icon: ""
    property real value: 0
    property color accentColor: Colors.accentBlue
    signal sliderMoved(real val)

    spacing: 10

    Rectangle {
        width: 32
        height: 32
        radius: 8
        color: Colors.surfaceBg
        border.color: Colors.borderSubtle
        border.width: 1

        Text {
            anchors.centerIn: parent
            text: root.icon
            color: root.accentColor
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 14
        }
    }

    Slider {
        id: slider
        Layout.fillWidth: true
        from: 0
        to: 100
        value: root.value
        onMoved: root.sliderMoved(value)

        background: Rectangle {
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 8
            width: slider.availableWidth
            height: implicitHeight
            radius: 4
            color: Colors.surfaceBg
            border.color: Colors.borderSubtle
            border.width: 1

            Rectangle {
                width: slider.visualPosition * parent.width
                height: parent.height
                color: root.accentColor
                radius: 4
            }
        }

        handle: Rectangle {
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            implicitWidth: 16
            implicitHeight: 16
            radius: 8
            color: Colors.textPrimary
            border.color: root.accentColor
            border.width: 2
        }
    }

    Text {
        text: Math.round(slider.value) + "%"
        color: Colors.textSecondary
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 11
        Layout.preferredWidth: 35
    }
}