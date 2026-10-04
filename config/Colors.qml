pragma Singleton
import QtQuick

QtObject {

    // Main Logo Colour
    readonly property color archlinux_color: "#1793d1"


    // Theme
    // readonly property color barBg: Qt.rgba(0, 0, 0, 0.5)
    readonly property color barBg: Qt.rgba(0, 0, 0, 0)          // Alternative Look

    // readonly property color barBorder: "whitesmoke"
    readonly property color barBorder: Qt.rgba(0, 0, 0, 0)      // Alternative Look

    // Glass look
    readonly property color glassBg: Qt.rgba(1, 1, 1, 0.08)
    readonly property color glassBorder: Qt.rgba(1, 1, 1, 0.18)

    // ── Catppuccin Mocha palette ──
    readonly property color accentMauve: "#cba6f7"
    readonly property color accentBlue: "#1793d1"
    readonly property color textPrimary: "whitesmoke"
    readonly property color textMuted: Qt.rgba(0.804, 0.839, 0.957, 0.55)
    readonly property color bgDark: "#11111b"

    // Battery Colour theme
    function batteryColor(critical, charging, powerProfile) {
        if (critical) return "#D9534F"        // muted brick red - overrides everything else
        if (charging) return "#7FB069"        // soft sage green

        switch (powerProfile) {
        case "PowerSaver":  return "#C4A855"  // muted gold
        case "Performance": return "#C47848"  // muted terracotta
        default:            return Colors.textPrimary
        }
    }
    
    function systemStateColor(state) {
        switch (state) {
            
            case "cpu-idle":        return "#74c7ec"
            case "cpu-low":         return "#89b4fa"
            case "cpu-moderate":    return "#89dceb"
            case "cpu-high":        return "#74c7ec"
            case "cpu-critical":    return "#f38ba8"

            case "mem-normal":      return "#cba6f7"
            case "mem-moderate":    return "#b4befe"
            case "mem-high":        return "#cba6f7"
            case "mem-critical":    return "#f5c2e7"

            case "temp-cool":       return "#89dceb"
            case "temp-normal":     return "#a6e3a1"
            case "temp-warm":       return "#f9e2af"
            case "temp-hot":        return "#fab387"
            case "temp-crit":       return "#f38ba8"

            default: return textPrimary
        }
    }
}