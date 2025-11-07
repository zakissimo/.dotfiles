import QtQuick

import Quickshell.Hyprland

import qs.Singletons
import qs.Singletons.Themes

BarBlock {
    id: root

    property var monitor: Hyprland.monitorFor(screen)
    property var activeWorkspaces: []

    Row {
        Component.onCompleted: {
            if (root.monitor && Workspaces.byMonitor[root.monitor.id])
                root.activeWorkspaces = Workspaces.byMonitor[root.monitor.id];
        }
        spacing: 10
        height: Math.max(1, childrenRect.height)
        width: Math.max(1, childrenRect.width)

        Connections {
            function onByMonitorChanged() {
                if (root.monitor && Workspaces.byMonitor[root.monitor.id])
                    root.activeWorkspaces = Workspaces.byMonitor[root.monitor.id];
                else
                    root.activeWorkspaces = [];
            }

            target: Workspaces
        }

        Repeater {
            model: root.activeWorkspaces.length

            Item {
                required property int index
                property bool focused: Hyprland.focusedMonitor && Hyprland.focusedMonitor.activeWorkspace && Hyprland.focusedMonitor.activeWorkspace.id === root.activeWorkspaces[index].id

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
                    hoverEnabled: true
                    onClicked: Workspaces.switchWorkspace(root.activeWorkspaces[index].id)
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
