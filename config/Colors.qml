pragma Singleton
import QtQuick

QtObject {
    // Exact hypr_bar glass theme palette
    readonly property color bgGlass: "#aa11111b"
    readonly property color bgGlassLighter: "#bb181825"
    readonly property color surfaceBg: "#33313244"
    readonly property color surfaceBgHover: "#5545475a"
    readonly property color cardBg: "#262837"
    readonly property color activeBg: "#45475a"
    readonly property color borderColor: "#33cdd6f4"
    readonly property color borderSubtle: "#1acdd6f4"

    // Text hierarchy
    readonly property color textPrimary: "#cdd6f4"
    readonly property color textSecondary: "#a6adc8"
    readonly property color textMuted: "#6c7086"

    // Accents
    readonly property color accentBlue: "#89b4fa"
    readonly property color accentMauve: "#cba6f7"
    readonly property color accentGreen: "#a6e3a1"
    readonly property color accentPeach: "#fab387"
    readonly property color accentYellow: "#f9e2af"
    readonly property color accentRed: "#f38ba8"
    readonly property color accentTeal: "#94e2d5"
    readonly property color accentLavender: "#b4befe"

    // The bar itself (.base_div in the original scss) is flat/opaque:
    // rgba(black, 0.5) background + solid whitesmoke border. This is
    // deliberately different from bgGlass/borderColor above, which are
    // for the Control Center / Calendar's "liquid glass" look.
    readonly property color barBg: Qt.rgba(0, 0, 0, 0.5)
    readonly property color barBorder: "whitesmoke"

    // Maps the cpu_state/memory_state/temp_state/class strings emitted by
    // the shell scripts to a color.
    function stateColor(state) {
        switch (state) {
        case "cpu-idle": return "#74c7ec"
        case "cpu-low": return accentBlue
        case "cpu-moderate": return "#89dceb"
        case "cpu-high": return "#74c7ec"
        case "cpu-critical": return accentRed
        case "mem-normal": return accentMauve
        case "mem-moderate": return accentLavender
        case "mem-high": return accentMauve
        case "mem-critical": return "#f5c2e7"
        case "temp-cool": return "#89dceb"
        case "temp-normal": return accentGreen
        case "temp-warm": return accentYellow
        case "temp-hot": return accentPeach
        case "temp-crit": return accentRed
        case "Charging": return accentGreen
        case "Discharging": return textPrimary
        case "critical": return accentRed
        default: return textPrimary
        }
    }
}