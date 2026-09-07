pragma Singleton
import QtQuick

QtObject {
    // ── Single source of truth ──
    readonly property int barHeight: 26

    // Derived sizes — mirrors variables.scss's own comment: don't edit
    // these directly, edit barHeight and these follow.
    readonly property real fontLogo: barHeight * 0.714
    readonly property real fontBase: barHeight * 0.518
    readonly property real fontSm: barHeight * 0.429
    readonly property real btnSize: barHeight * 0.714

    // Derived spacing/padding
    readonly property real padEdge: barHeight * 0.286
    readonly property real padLogoH: barHeight * 0.071
    readonly property real padWsBtn: barHeight * 0.036
    readonly property real padTipV: barHeight * 0.214
    readonly property real padTipH: barHeight * 0.357

}