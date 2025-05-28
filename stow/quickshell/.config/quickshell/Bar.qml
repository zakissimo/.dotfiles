import Quickshell
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

import "Widgets"
import "Singletons/Themes"

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
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

            RowLayout {
                id: rootBlocks

                spacing: 0
                anchors.fill: parent

                RowLayout {
                    id: leftBlock

                    Layout.leftMargin: 10

                    Workspaces {}
                }

                Item {
                    id: leftSpacer
                    Layout.fillWidth: true
                }

                RowLayout {
                    id: centerBlock

                    spacing: 10

                    Clocks {}
                }

                Item {
                    id: rightSpacer
                    Layout.fillWidth: true
                }

                RowLayout {
                    id: rightBlock

                    spacing: 10
                    Layout.rightMargin: 10

                    Network {}
                    Resources {}
                    PowerManagement {}
                    SysTray {}
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
}
