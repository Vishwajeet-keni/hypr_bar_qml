import QtQuick
import Quickshell
import Quickshell.Io

// Periodically runs a script and parses its stdout as JSON. Call poll()
// directly (optionally with extra args) to trigger an immediate one-off
// run, e.g. after a toggle click, without waiting for the next tick.
Item {
    id: root
    property string scriptPath: ""
    property var scriptArgs: []
    property int interval: 2000
    property var data: ({})

    Process {
        id: proc
        stdout: SplitParser {
            onRead: raw => {
                const text = raw.trim()
                if (!text)
                    return
                try {
                    root.data = JSON.parse(text)
                } catch (e) {
                    console.warn("JsonPoller: bad JSON from", root.scriptPath, ":", text)
                }
            }
        }
    }

    function poll(extraArgs) {
        if (root.scriptPath === "" || proc.running)
            return
        const args = (extraArgs && extraArgs.length) ? extraArgs : root.scriptArgs
        proc.command = [root.scriptPath].concat(args)
        proc.running = true
    }

    Timer {
        interval: root.interval
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.poll()
    }
}
