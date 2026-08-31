import QtQuick

// Plain (non-singleton) color palette object. Instantiated once in
// shell.qml and passed down to every component as `pal`. Colors match the
// original hypr_bar scss/variables.scss (Catppuccin Mocha).
//
// Named "Colors" rather than "Palette" because QtQuick already ships a
// built-in `Palette` type (QQuickPalette) - a same-directory file sharing
// that name loses to the module-imported one, so `Palette {}` would
// silently construct Qt's built-in type instead of ours.
QtObject {
    readonly property color mauve: "#cba6f7"       // accent-mauve
    readonly property color blue: "#89b4fa"        // accent-blue
    readonly property color textPrimary: "#cdd6f4"
    readonly property color textMuted: Qt.rgba(0.804, 0.839, 0.957, 0.55)
    readonly property color bgDark: "#11111b"      // catppuccin "crust"
    readonly property color archBlue: "#1793d1"

    readonly property color cpuIdle: "#74c7ec"
    readonly property color cpuLow: "#89b4fa"
    readonly property color cpuModerate: "#89dceb"
    readonly property color cpuHigh: "#74c7ec"
    readonly property color cpuCritical: "#f38ba8"

    readonly property color memNormal: "#cba6f7"
    readonly property color memModerate: "#b4befe"
    readonly property color memHigh: "#cba6f7"
    readonly property color memCritical: "#f5c2e7"

    readonly property color tempCool: "#89dceb"
    readonly property color tempNormal: "#a6e3a1"
    readonly property color tempWarm: "#f9e2af"
    readonly property color tempHot: "#fab387"
    readonly property color tempCrit: "#f38ba8"

    // Maps the *_state strings emitted by the shell scripts to a color,
    // same mapping as the .cpu-*/.mem-*/.temp-*/battery classes in bar.scss.
    function stateColor(state) {
        switch (state) {
        case "cpu-idle": return cpuIdle
        case "cpu-low": return cpuLow
        case "cpu-moderate": return cpuModerate
        case "cpu-high": return cpuHigh
        case "cpu-critical": return cpuCritical
        case "mem-normal": return memNormal
        case "mem-moderate": return memModerate
        case "mem-high": return memHigh
        case "mem-critical": return memCritical
        case "temp-cool": return tempCool
        case "temp-normal": return tempNormal
        case "temp-warm": return tempWarm
        case "temp-hot": return tempHot
        case "temp-crit": return tempCrit
        case "Charging": return "#4caf50"
        case "Discharging": return textPrimary
        case "critical": return cpuCritical
        default: return textPrimary
        }
    }
}
