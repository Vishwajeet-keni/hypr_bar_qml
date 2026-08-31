import Quickshell.Io
import QtQuick

// Keeps a long-running process alive and parses each line of its stdout as
// JSON. This is the QML equivalent of eww's `(deflisten ... "script")`
// (used originally for battery.sh's `upower --monitor` loop).
Item {
    id: root
    property string command: ""
    property var data: ({})

    Process {
        running: root.command.length > 0
        command: ["bash", "-c", root.command]
        stdout: SplitParser {
            onRead: line => {
                const text = line.trim()
                if (!text)
                    return
                try {
                    root.data = JSON.parse(text)
                } catch (e) {
                    // Non-JSON lines (debug/comment output) are ignored.
                }
            }
        }
    }
}
