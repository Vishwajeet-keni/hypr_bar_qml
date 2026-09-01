pragma Singleton
import QtQuick

// Resolves scripts/ relative to this file's own location, so it works
// whether this repo is ~/.config/quickshell directly or a subfolder of it.
QtObject {
    readonly property string scriptsDir: Qt.resolvedUrl("../scripts/").toString().replace("file://", "")

    function script(name) {
        return scriptsDir + name
    }
}
