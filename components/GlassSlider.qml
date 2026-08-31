import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

// Replaces the cc-slider reusable widget from tiles.yuck.
ColumnLayout {
    id: root
    property var pal
    property string label: ""
    property real from: 0
    property real to: 100
    property real value: 0
    signal moved(real value)

    spacing: 6

    Text { text: root.label; color: root.pal.textPrimary; font.pixelSize: 13; font.bold: true }

    Slider {
        id: slider
        Layout.fillWidth: true
        from: root.from
        to: root.to
        value: root.value
        onPressedChanged: if (!pressed) root.moved(slider.value)

        // Keep the slider in sync with externally-updated values (e.g. the
        // poller reporting a new brightness/volume level) except while the
        // user is actively dragging it.
        Binding on value {
            value: root.value
            when: !slider.pressed
        }

        background: Rectangle {
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            width: slider.availableWidth
            height: 20
            radius: 8
            color: Qt.rgba(1, 1, 1, 0.1)
            Rectangle {
                width: slider.visualPosition * parent.width
                height: parent.height
                radius: 8
                color: root.pal.mauve
            }
        }
        handle: Item {}
    }
}
