import "root:/Singletons"
import "root:/Singletons/Themes"

import QtQuick
import QtQuick.Layouts

import Quickshell

LazyLoader {
    id: popupLoader

    property var parentWin: null

    loading: true

    function togglePopup() {
        if (!popupLoader.item.visible) {
            Calendar.refresh();
        }

        popupLoader.item.visible = !popupLoader.item.visible;
    }

    PopupWindow {

        anchor.window: popupLoader.parentWin
        anchor.rect.x: popupLoader.parentWin.width / 2 - width / 2
        anchor.rect.y: popupLoader.parentWin.height + 3

        color: "transparent"

        Rectangle {
            anchors.fill: parent
            color: Colors.surface
            // color: "transparent"
            radius: 7
            border.color: Colors.overlay
            border.width: 3

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 5

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 5
                    // You'd add buttons here to navigate months
                    Text {
                        text: Calendar.monthNames[Calendar.currentMonth] + " " + Calendar.currentYear
                        color: Colors.text
                        font.pixelSize: 16
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 0
                    Repeater {
                        model: Calendar.dayNamesShort
                        Text {
                            text: modelData
                            color: Colors.text
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                        }
                    }
                }

                // Calendar Grid (Days)
                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 0

                    // Iterate through weeks (rows)
                    Repeater {
                        model: Math.ceil(Calendar.grid.length / 7) // Number of rows needed

                        delegate: RowLayout {
                            property int rowIndex: index
                            Layout.fillWidth: true
                            spacing: 0

                            Repeater {
                                model: 7

                                delegate: Rectangle {
                                    property int row: rowIndex // explicitly pass from outer
                                    property int col: index
                                    property int globalIndex: (row * 7) + col

                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    color: {
                                        if (Calendar.currentDay === parseInt(Calendar.grid[globalIndex])) {
                                            return Colors.highlightHigh; // Highlight current day
                                        }
                                        return "transparent";
                                    }
                                    border.color: Colors.muted
                                    border.width: 0.5

                                    Text {
                                        text: {
                                            return Calendar.grid.length > globalIndex ? Calendar.grid[globalIndex] : "";
                                        }

                                        color: Colors.text
                                        font.pixelSize: 14
                                        anchors.centerIn: parent
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        implicitWidth: 230
        implicitHeight: 200
    }
}
