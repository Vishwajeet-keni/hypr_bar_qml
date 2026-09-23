import QtQuick
import Quickshell.Io

Item {
    id: root
    property string command: ""
    property int interval: 2000
    property var data: ({})

    Process {
        id: proc
        command: ["bash", "-c", root.command]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    root.data = JSON.parse(this.text)
                } catch (e) {
                    console.warn("Poller: bad JSON from", root.command, ":", this.text)
                }
            }
        }
        stderr: StdioCollector {
            onStreamFinished: {
                if (this.text.trim()) console.warn("Poller: stderr from", root.command, ":", this.text)
            }
        }
    }
    
    function poll() {
        if (!proc.running) proc.running = true
    }

    Component.onCompleted: poll()

    Timer {
        interval: root.interval
        running: root.interval > 0
        repeat: true
        onTriggered: root.poll()
    }
}