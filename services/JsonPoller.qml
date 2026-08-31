import Quickshell.Io
import QtQuick

// Runs a script on an interval and parses its stdout as JSON.
// This is the QML equivalent of eww's `(defpoll ... :interval "Ns" "script")`.
//
// Usage:
//   JsonPoller { id: p; script: "$HOME/.config/quickshell/scripts/wifi.sh"; interval: 5000 }
//   Text { text: p.data.icon }
//   ... p.poll(["toggle"])   // run once with extra args, e.g. for a click handler
//
// `script` is expanded through `bash -c`, so "$HOME" / "~" work as expected
// without needing Quickshell.env() plumbing.
Item {
    id: root

    property string script: ""
    // Polling interval in ms. Set to 0 to disable automatic re-polling
    // (e.g. if this poller is only ever triggered manually via poll()).
    property int interval: 2000
    // Last parsed JSON payload from the script's stdout.
    property var data: ({})

    Process {
        id: proc
        stdout: StdioCollector {
            onStreamFinished: {
                const text = this.text.trim()
                if (!text)
                    return
                try {
                    root.data = JSON.parse(text)
                } catch (e) {
                    console.warn("JsonPoller: could not parse output of", root.script, ":", text)
                }
            }
        }
    }

    // Run the script once, optionally with extra CLI args, e.g.
    // poll(["set", "70"]) => `script.sh set 70`
    function poll(args) {
        if (proc.running)
            return
        const cmd = root.script + (args && args.length ? " " + args.join(" ") : "")
        proc.command = ["bash", "-c", cmd]
        proc.running = true
    }

    Component.onCompleted: poll()

    Timer {
        interval: root.interval
        running: root.interval > 0
        repeat: true
        onTriggered: root.poll()
    }
}
