import qs.Widgets
import qs.Singletons.Themes

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: window

        WlrLayershell.namespace: "quickshell:bar"
        property var modelData
        screen: modelData

        anchors {
            top: true
            left: true
            right: true
        }

        color: Colors.base
        implicitHeight: 25
        HyprlandWindow.opacity: 1.0

        Calendar {
            id: calendar

            parentWin: window
        }

        Item {
            id: rootBlocks

            anchors.fill: parent

            Item {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                implicitWidth: leftBlock.implicitWidth
                implicitHeight: leftBlock.implicitHeight

                RowLayout {
                    id: leftBlock

                    spacing: 10

                    Workspaces {}
                }
            }

            Item {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: date.width / 2
                implicitWidth: centerBlock.implicitWidth
                implicitHeight: centerBlock.implicitHeight

                RowLayout {
                    id: centerBlock

                    spacing: 10

                    Clocks {}
                    Date {
                        id: date
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: calendar.togglePopup()
                }
            }

            Item {
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                implicitWidth: rightBlock.implicitWidth
                implicitHeight: rightBlock.implicitHeight

                RowLayout {
                    id: rightBlock

                    spacing: 10

                    Audio {}
                    Network {}
                    Resources {}
                    PowerManagement {}
                    SysTray {}
                }
            }

            Binding {
                target: centerBlock.Layout
                property: "leftMargin"
                value: rightBlock ? rightBlock.implicitWidth : 0
                when: rightBlock && rightBlock.implicitWidth > 0
            }

            Binding {
                target: centerBlock.Layout
                property: "rightMargin"
                value: leftBlock ? leftBlock.implicitWidth : 0
                when: leftBlock && leftBlock.implicitWidth > 0
            }
        }
    }
}
