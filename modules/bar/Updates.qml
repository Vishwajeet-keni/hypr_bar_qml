import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import "../../assets"
import "../../config"

Item {
    id: root
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    property int pacmanCount: 0
    property int yayCount: 0
    readonly property int totalCount: pacmanCount + yayCount

    function countLines(text) {
        const t = text.trim()
        return t.length ? t.split("\n").length : 0
    }

    Process {
        id: pacmanProc
        command: ["timeout", "10", "pacman", "-Qu"]
        stdout: StdioCollector {
            onStreamFinished: root.pacmanCount = root.countLines(this.text)
        }
    }
    Process {
        id: yayProc
        command: ["timeout", "30", "yay", "-Qu"]
        stdout: StdioCollector {
            onStreamFinished: root.yayCount = root.countLines(this.text)
        }
    }

    function refresh() {
        if (!pacmanProc.running) pacmanProc.running = true
        if (!yayProc.running) yayProc.running = true
    }

    Component.onCompleted: refresh()
    Timer {
        interval: 3600000 // 1 hour, same cadence as the original
        running: true
        repeat: true
        onTriggered: root.refresh()
    }

    RowLayout {
        id: row
        anchors.fill: parent
        spacing: 5
        
        Text {
            text: Icons.updates
            color: Colors.textPrimary
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: Vars.fontBase
        }
        Text {
            text: root.totalCount
            color: Colors.textPrimary
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: Vars.fontBase
            font.bold: true
        }
    }

    MouseArea { id: ma; anchors.fill: parent; hoverEnabled: true }
}