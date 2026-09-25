import QtQuick
import QtQuick.Layouts
import "../../assets"
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
            spacing: 5
            Text {
                text: Icons.system_stats.cpu
                color: Colors.stateColor(SystemStatsService.cpuState)
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: Vars.fontBase
            }
            Text {
                text: SystemStatsService.cpuUsage + "%"
                color: Colors.stateColor(SystemStatsService.cpuState)
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: Vars.fontBase
                font.bold: true
            }
        }

        RowLayout {
            spacing: 5
            Text {
                text: Icons.system_stats.mem
                color: Colors.stateColor(SystemStatsService.memState)
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: Vars.fontBase
            }
            Text {
                text: SystemStatsService.memUsage + "%"
                color: Colors.stateColor(SystemStatsService.memState)
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: Vars.fontBase
                font.bold: true
            }
        }

        RowLayout {
            spacing: 5
            Text {
                text: Icons.system_stats.temp[SystemStatsService.tempState]
                color: Colors.stateColor(SystemStatsService.tempState)
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: Vars.fontBase
            }
            Text {
                text: SystemStatsService.tempLvl + "\u00b0C"
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