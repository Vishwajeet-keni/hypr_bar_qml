import QtQuick
import QtQuick.Layouts
import "../../assets"
import "../../config"

Item {
    id: root
    implicitWidth:  row.implicitWidth
    implicitHeight: row.implicitHeight

    RowLayout{ 
        id: row
        anchors.fill: parent
        spacing: 0

        Text{
            text: Icons.menu
            color: AppState.menuOpen ? Colors.accentMauve : Colors.textPrimary
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: Vars.fontBase + 3
        }
    }

    MouseArea{
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