import QtQuick
import QtQuick.Layouts
import "../../config"
import "../../services"

Item {
    id: root
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    RowLayout {
        id: row
        anchors.fill: parent
        spacing: 8

        RowLayout {
            spacing: 8
            Text {
                text: SystemStatsService.cpuIcon
                color: Colors.stateColor(SystemStatsService.cpuState)
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: Vars.fontBase
            }
            Text {
                text: SystemStatsService.cpuUsage.toFixed(1)
                color: Colors.stateColor(SystemStatsService.cpuState)
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: Vars.fontBase
                font.bold: true
            }
        }

        RowLayout {
            spacing: 8
            Text {
                text: SystemStatsService.memIcon
                color: Colors.stateColor(SystemStatsService.memState)
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: Vars.fontBase
            }
            Text {
                text: SystemStatsService.memUsage.toFixed(1) + "%"
                color: Colors.stateColor(SystemStatsService.memState)
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: Vars.fontBase
                font.bold: true
            }
        }

        RowLayout {
            spacing: 5
            Text {
                text: SystemStatsService.tempIcon
                color: Colors.stateColor(SystemStatsService.tempState)
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: Vars.fontBase
            }
            Text {
                text: SystemStatsService.tempLvl.toFixed(1) + "\u00b0C"
                color: Colors.stateColor(SystemStatsService.tempState)
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: Vars.fontBase
                font.bold: true
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: AppState.systemGraphOpen = !AppState.systemGraphOpen
    }
}