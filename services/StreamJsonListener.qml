import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    property string scriptPath: ""
    property var scriptArgs: []
    property var data: ({})

    Process {
        id: proc
        command: [root.scriptPath].concat(root.scriptArgs)
        running: root.scriptPath !== ""
        stdout: SplitParser {
            onRead: raw => {
                try {
                    root.data = JSON.parse(raw);
                } catch (e) {}
            }
        }
    }
}