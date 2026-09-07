pragma Singleton
import QtQuick

QtObject {

    // Main Logo Colour
    readonly property color archlinux_color: "#1793d1"

    // Theme
    readonly property color barBg: Qt.rgba(0, 0, 0, 0.5)
    readonly property color barBorder: "whitesmoke"

    // ── Catppuccin Mocha palette ──
    readonly property color accentMauve: "#cba6f7"
    readonly property color accentBlue: "#1793d1"
    readonly property color textPrimary: "#cdd6f4"
    readonly property color textMuted: Qt.rgba(0.804, 0.839, 0.957, 0.55)
    readonly property color bgDark: "#11111b"
}