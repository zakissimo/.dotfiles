import QtQuick
import Quickshell.Hyprland

import qs.Singletons.Themes
import qs.Widgets.TextVariants

BarBlock {
    id: root

    property var monitor: Hyprland.monitorFor(screen)

    Row {
        spacing: 10
        height: Math.max(1, childrenRect.height)
        width: Math.max(1, childrenRect.width)

        Repeater {
            model: Hyprland.workspaces

            Item {
                required property var modelData

                visible: modelData.monitor && root.monitor && modelData.monitor.id === root.monitor.id

                width: visible ? workspaceText.width : 0
                height: visible ? workspaceText.height * 2 : 0
                clip: true

                readonly property bool isFocused: modelData.active && root.monitor && root.monitor.focused

                Body {
                    id: workspaceText
                    anchors.centerIn: parent
                    text: modelData.id > 0 ? modelData.id.toString() : modelData.name
                    color: isFocused ? Colors.text : Colors.muted
                    font.bold: isFocused
                }

                Rectangle {
                    visible: isFocused
                    height: 2
                    color: Colors.text
                    anchors {
                        left: workspaceText.left
                        right: workspaceText.right
                        top: workspaceText.bottom
                        topMargin: -3
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Hyprland.dispatch(`workspace ${modelData.id}`);
                    }
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
