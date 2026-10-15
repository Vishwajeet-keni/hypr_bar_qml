import QtQuick
import Quickshell
import Quickshell.Wayland

import "../config"

PanelWindow {
    id: calendarWin

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "eww-control-panel"
    exclusiveZone: 0

    anchors {
        top: true
    }
    margins {
        top: Vars.barHeight + 6
    }

    implicitWidth: card.implicitWidth
    implicitHeight: card.implicitHeight
    visible: AppState.calendarOpen
    color: "transparent"

    readonly property var now: new Date()
    property int viewYear: new Date().getFullYear()
    property int viewMonth: new Date().getMonth()

    onVisibleChanged: {
        if (visible) {
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

    // Outer Glass Card
    Rectangle {
        id: card
        implicitWidth: col.implicitWidth + 24
        implicitHeight: col.implicitHeight + 24
        radius: 14
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

                    // Month navigator: < Month >
                    Row {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 8

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
                                cursorShape: Qt.PointingHandCursor
                                onClicked: calendarWin.prevMonth()
                            }
                        }

                        Text {
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
                                cursorShape: Qt.PointingHandCursor
                                onClicked: calendarWin.nextMonth()
                            }
                        }
                    }

                    // Flexible Spacer
                    Item {
                        width: parent.width - (parent.children[0].width + parent.children[2].width + 20)
                        height: 1
                    }

                    // Year navigator: < Year >
                    Row {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 8

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
                                cursorShape: Qt.PointingHandCursor
                                onClicked: calendarWin.viewYear++
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

                // Month Numbers Grid
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
                            const remaining = (cells.length <= 35 ? 35 : 42) - cells.length
                            for (let n = 1; n <= remaining; n++) {
                                cells.push({ day: n, isCurrentMonth: false })
                            }
                            return cells
                        }

                        delegate: Item {
                            id: dayCell
                            required property var modelData
                            width: 30
                            height: 26

                            readonly property bool isToday: modelData.isCurrentMonth
                                && modelData.day === calendarWin.now.getDate()
                                && calendarWin.viewMonth === calendarWin.now.getMonth()
                                && calendarWin.viewYear === calendarWin.now.getFullYear()

                            // Rounded pill for current date / hover
                            Rectangle {
                                anchors.centerIn: parent
                                width: 28
                                height: 24
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