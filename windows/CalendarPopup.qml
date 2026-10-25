import QtQuick
import Quickshell

import "../config"

PopupWindow {
    id: calendarWin

    property var anchorWindow

    anchor.window: anchorWindow
    anchor.rect.x: Math.round(AppState.calendarAnchorX + AppState.calendarAnchorWidth / 2 - implicitWidth / 2)
    anchor.rect.y: anchorWindow ? anchorWindow.height : 0
    anchor.adjustment: PopupAdjustment.SlideX

    // Fixed geometry prevents Wayland surface resizing/shaking when switching months
    readonly property int cardWidth: 266
    readonly property int cardHeight: 256

    implicitWidth: cardWidth + 32
    implicitHeight: cardHeight + 32
    visible: AppState.calendarOpen || dropProgress > 0.001
    color: "transparent"

    readonly property var now: new Date()
    property int viewYear: new Date().getFullYear()
    property int viewMonth: new Date().getMonth()

    // ── Caelestia Expressive Spatial + Liquid Drop Progress ──
    property real dropProgress: AppState.calendarOpen ? 1.0 : 0.0

    Behavior on dropProgress {
        NumberAnimation {
            // Slower, weighted Caelestia timing (520ms open, 340ms retract)
            duration: AppState.calendarOpen ? 520 : 340
            easing.type: Easing.BezierSpline
            // Caelestia's expressiveDefaultSpatial spring curve on open, smooth decel on close
            easing.bezierCurve: AppState.calendarOpen
                ? [0.38, 1.21, 0.22, 1.0, 1.0, 1.0]
                : [0.3, 0.0, 0.8, 0.15, 1.0, 1.0]
        }
    }

    onVisibleChanged: {
        if (visible && AppState.calendarOpen) {
            const d = new Date()
            viewYear = d.getFullYear()
            viewMonth = d.getMonth()
        }
    }

    function nextMonth() {
        if (viewMonth === 11) {
            viewMonth = 0
            viewYear++
        } else {
            viewMonth++
        }
    }

    function prevMonth() {
        if (viewMonth === 0) {
            viewMonth = 11
            viewYear--
        } else {
            viewMonth--
        }
    }

    function monthName(m) {
        return ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"][m]
    }

    // ── Caelestia Popout Wrapper (Clipped Top-Down Unroll + Liquid Drop) ──
    Item {
        id: caelestiaClipWrapper
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 8

        // Expands smoothly from top center like Caelestia's bar popouts
        width: calendarWin.cardWidth + 16
        height: Math.max(1, (calendarWin.cardHeight + 16) * Math.min(1.15, Math.pow(calendarWin.dropProgress, 0.7)))
        clip: true

        Item {
            id: animWrapper
            anchors.horizontalCenter: parent.horizontalCenter
            width: calendarWin.cardWidth
            height: calendarWin.cardHeight

            // Slides down out of the top bar while unrolling
            y: 8 - (1.0 - calendarWin.dropProgress) * 45
            opacity: Math.max(0.0, Math.min(1.0, calendarWin.dropProgress * 1.8))

            transform: [
                Scale {
                    origin.x: animWrapper.width / 2
                    origin.y: 0
                    // Liquid drop stretch: narrow droplet at start, blooms out with Caelestia spring
                    xScale: Math.max(0.18, 0.18 + 0.82 * calendarWin.dropProgress)
                    yScale: Math.max(0.30, Math.pow(Math.max(0.001, calendarWin.dropProgress), 0.65))
                }
            ]

            // Outer Glass Card
            Rectangle {
                id: card
                anchors.fill: parent
                // Morphs from a round pill droplet into the 14px rounded rectangle
                radius: Math.max(14, Math.min(width / 2, 14 + (width / 2 - 14) * Math.max(0.0, 1.0 - calendarWin.dropProgress)))
                color: Colors.glassBg
                border.color: "whitesmoke"
                border.width: 1

                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) {
                            AppState.cancelCalendarClose()
                        } else {
                            AppState.scheduleCalendarClose()
                        }
                    }
                }

                Column {
                    id: col
                    anchors.centerIn: parent
                    spacing: 6
                    opacity: Math.max(0.0, Math.min(1.0, (calendarWin.dropProgress - 0.2) / 0.8))

                    // ── Top Header Pill (< Month >   < Year >) ──
                    Rectangle {
                        id: headerPill
                        width: gridContent.implicitWidth + 8
                        height: 28
                        radius: height / 2.5
                        color: Colors.glassBg
                        border.color: "whitesmoke"
                        border.width: 1

                        Row {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10

                            // Month navigator: < Month > (Fixed width so changing month names never shifts the header)
                            Item {
                                width: 110
                                height: parent.height

                                Row {
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 6

                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "<"
                                        color: mPrevMa.containsMouse ? "#ffffff" : Colors.textMuted
                                        font.family: "JetBrains Mono Nerd Font"
                                        font.pixelSize: 11
                                        font.bold: true
                                        MouseArea {
                                            id: mPrevMa
                                            anchors.fill: parent
                                            anchors.margins: -4
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: calendarWin.prevMonth()
                                        }
                                    }

                                    Text {
                                        width: 76
                                        horizontalAlignment: Text.AlignHCenter
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: calendarWin.monthName(calendarWin.viewMonth)
                                        color: Colors.textPrimary
                                        font.family: "JetBrains Mono Nerd Font"
                                        font.pixelSize: 13
                                    }

                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: ">"
                                        color: mNextMa.containsMouse ? "#ffffff" : Colors.textMuted
                                        font.family: "JetBrains Mono Nerd Font"
                                        font.pixelSize: 11
                                        font.bold: true
                                        MouseArea {
                                            id: mNextMa
                                            anchors.fill: parent
                                            anchors.margins: -4
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: calendarWin.nextMonth()
                                        }
                                    }
                                }
                            }

                            // Spacer
                            Item {
                                width: parent.width - 196
                                height: 1
                            }

                            // Year navigator: < Year >
                            Item {
                                width: 66
                                height: parent.height

                                Row {
                                    anchors.right: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 6

                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "<"
                                        color: yPrevMa.containsMouse ? "#ffffff" : Colors.textMuted
                                        font.family: "JetBrains Mono Nerd Font"
                                        font.pixelSize: 11
                                        font.bold: true
                                        MouseArea {
                                            id: yPrevMa
                                            anchors.fill: parent
                                            anchors.margins: -4
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: calendarWin.viewYear--
                                        }
                                    }

                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: String(calendarWin.viewYear)
                                        color: Colors.textPrimary
                                        font.family: "JetBrains Mono Nerd Font"
                                        font.pixelSize: 13
                                    }

                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: ">"
                                        color: yNextMa.containsMouse ? "#ffffff" : Colors.textMuted
                                        font.family: "JetBrains Mono Nerd Font"
                                        font.pixelSize: 11
                                        font.bold: true
                                        MouseArea {
                                            id: yNextMa
                                            anchors.fill: parent
                                            anchors.margins: -4
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: calendarWin.viewYear++
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // ── Grid Area ──
                    Column {
                        id: gridContent
                        spacing: 4

                        // Day headers pill strip
                        Rectangle {
                            width: dayGrid.implicitWidth + 8
                            height: 24
                            radius: height / 2.5
                            color: Colors.glassBg
                            border.color: "whitesmoke"
                            border.width: 1

                            Grid {
                                id: dayGrid
                                columns: 7
                                spacing: 4
                                anchors.centerIn: parent

                                Repeater {
                                    model: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                                    delegate: Item {
                                        width: 30
                                        height: 20

                                        Text {
                                            anchors.centerIn: parent
                                            text: modelData
                                            color: Colors.textMuted
                                            font.family: "JetBrains Mono Nerd Font"
                                            font.pixelSize: 11
                                        }
                                    }
                                }
                            }
                        }

                        // Month Numbers Grid (Always locked to 42 cells / 6 rows so height never jumps)
                        Grid {
                            columns: 7
                            spacing: 4
                            anchors.horizontalCenter: parent.horizontalCenter

                            Repeater {
                                model: {
                                    const y = calendarWin.viewYear
                                    const m = calendarWin.viewMonth
                                    const firstDayIndex = new Date(y, m, 1).getDay()
                                    const daysInMonth = new Date(y, m + 1, 0).getDate()
                                    const prevMonthDays = new Date(y, m, 0).getDate()

                                    const cells = []
                                    for (let i = firstDayIndex - 1; i >= 0; i--) {
                                        cells.push({ day: prevMonthDays - i, isCurrentMonth: false })
                                    }
                                    for (let d = 1; d <= daysInMonth; d++) {
                                        cells.push({ day: d, isCurrentMonth: true })
                                    }
                                    // Always pad to 42 (6 rows) so switching months never resizes the card
                                    const remaining = 42 - cells.length
                                    for (let n = 1; n <= remaining; n++) {
                                        cells.push({ day: n, isCurrentMonth: false })
                                    }
                                    return cells
                                }

                                delegate: Item {
                                    id: dayCell
                                    required property var modelData
                                    width: 30
                                    height: 24

                                    readonly property bool isToday: modelData.isCurrentMonth
                                        && modelData.day === calendarWin.now.getDate()
                                        && calendarWin.viewMonth === calendarWin.now.getMonth()
                                        && calendarWin.viewYear === calendarWin.now.getFullYear()

                                    // Rounded pill for current date / hover
                                    Rectangle {
                                        anchors.centerIn: parent
                                        width: 28
                                        height: 22
                                        radius: height / 2.5
                                        color: dayCell.isToday 
                                            ? Qt.rgba(1, 1, 1, 0.22)
                                            : (cellHover.hovered ? Colors.glassBg : "transparent")
                                        border.color: dayCell.isToday ? "whitesmoke" : "transparent"
                                        border.width: 1
                                    }

                                    Text {
                                        anchors.centerIn: parent
                                        text: String(modelData.day)
                                        color: {
                                            if (dayCell.isToday) return Colors.textPrimary
                                            if (!modelData.isCurrentMonth) return Qt.rgba(0.7, 0.7, 0.7, 0.35)
                                            return Colors.textPrimary
                                        }
                                        font.family: "JetBrains Mono Nerd Font"
                                        font.pixelSize: 12
                                        font.bold: dayCell.isToday
                                    }

                                    HoverHandler {
                                        id: cellHover
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}