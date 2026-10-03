import QtQuick
import QtQuick.Layouts
import "../../assets"
import "../../config"

Item {
    id: root
    implicitWidth: row1.implicitWidth + 8
    implicitHeight: Vars.btnSize

    readonly property bool hovered: ma.containsMouse

    // Single source of truth for the reveal motion - the width-grow and
    // the spacing-open animate in lockstep because they share these,
    // not because their numbers happen to match by coincidence.
    readonly property int revealDuration: 200
    readonly property int fadeDuration: 150
    readonly property int revealEasing: Easing.OutCubic

    Rectangle {
        id: rectangle1
        anchors.fill: parent
        radius: height / 2.5
        color: root.hovered ? Colors.glassBg : "transparent"
        border.color: root.hovered ? Colors.glassBorder : "transparent"
        border.width: 1
        Behavior on color { ColorAnimation { duration: root.fadeDuration } }
        Behavior on border.color { ColorAnimation { duration: root.fadeDuration } }

        RowLayout {
            id: row1
            anchors.centerIn: parent
            spacing: root.hovered ? 6 : 0
            Behavior on spacing { NumberAnimation { duration: root.revealDuration; easing.type: root.revealEasing } }

            Item {
                id: revealItem
                Layout.alignment: Qt.AlignVCenter
                clip: true
                implicitHeight: row2.implicitHeight + 4
                implicitWidth: root.hovered ? row2.implicitWidth + 8 : 0
                Behavior on implicitWidth { NumberAnimation { duration: root.revealDuration; easing.type: root.revealEasing } }

                RowLayout {
                    id: row2
                    anchors.centerIn: parent
                    spacing: 6
                    Text {
                        text: "\uf1eb" // placeholder - wifi
                        color: Colors.textPrimary
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: Vars.fontSm
                    }
                    Text {
                        text: "\uf294" // placeholder - bluetooth
                        color: Colors.textPrimary
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: Vars.fontSm
                    }
                }
            }

            Text {
                text: Icons.menu
                color: AppState.menuOpen ? Colors.accentMauve : Colors.textPrimary
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: Vars.fontBase + 3
            }
        }
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: AppState.menuOpen = true
        onExited: closeTimer.restart()
        onEntered: closeTimer.stop()
    }

    Timer {
        id: closeTimer
        interval: 300
        onTriggered: AppState.menuOpen = false
    }
}