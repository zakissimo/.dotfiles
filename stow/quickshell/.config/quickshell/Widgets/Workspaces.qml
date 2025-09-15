import qs.Singletons
import qs.Singletons.Themes

import Quickshell.Hyprland

import QtQuick

BarBlock {
    id: root

    property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
    property var activeWorkspaces: []

    Row {
        Connections {
            target: Workspaces
            function onByMonitorChanged() {
                if (root.monitor && Workspaces.byMonitor[root.monitor.id]) {
                    root.activeWorkspaces = Workspaces.byMonitor[root.monitor.id];
                } else {
                    root.activeWorkspaces = [];
                }
            }
        }

        Component.onCompleted: {
            if (root.monitor && Workspaces.byMonitor[root.monitor.id]) {
                root.activeWorkspaces = Workspaces.byMonitor[root.monitor.id];
            }
        }

        spacing: 10

        height: Math.max(1, childrenRect.height)
        width: Math.max(1, childrenRect.width)

        Repeater {
            model: root.activeWorkspaces.length

            Item {
                required property int index
                property bool focused: Hyprland.focusedMonitor?.activeWorkspace?.id === root.activeWorkspaces[index].id

                width: workspaceText.width
                height: workspaceText.height * 2

                Text {
                    id: workspaceText

                    anchors.centerIn: parent
                    text: root.activeWorkspaces[index] ? root.activeWorkspaces[index].id.toString() : ""
                    color: focused ? Colors.text : Colors.muted
                    font.bold: focused
                }

                Rectangle {
                    visible: focused
                    anchors {
                        left: workspaceText.left
                        right: workspaceText.right
                        top: workspaceText.bottom
                        topMargin: -3
                    }
                    height: 2
                    color: Colors.text
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: Workspaces.switchWorkspace(root.activeWorkspaces[index].id)
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
