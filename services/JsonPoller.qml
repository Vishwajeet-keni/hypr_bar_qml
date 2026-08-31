import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    property string scriptPath: ""
    property var scriptArgs: []
    property int interval: 2000
    property var data: ({})

    Process {
        id: proc
        command: [root.scriptPath].concat(root.scriptArgs)
        stdout: SplitParser {
            onRead: raw => {
                try {
                    root.data = JSON.parse(raw);
                } catch (e) {}
            }
        }
    }

    Timer {
        interval: root.interval
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (root.scriptPath !== "") {
                proc.running = true;
            }
        }
    }
}