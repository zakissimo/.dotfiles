pragma Singleton

import Quickshell
import Quickshell.Hyprland

import QtQuick

Singleton {
    id: root

    property var byMonitor: groupByMonitor(Hyprland.workspaces.values)

    function groupByMonitor(wsList) {
        let monitorMap = {};

        for (let ws of wsList) {
            let monitorId = ws?.monitor?.id;

            if (monitorId !== undefined && monitorId !== null) {
                if (!monitorMap[monitorId]) {
                    monitorMap[monitorId] = [];
                }
                monitorMap[monitorId].push(ws);
            }
        }

        return monitorMap;
    }

    function switchWorkspace(w: int): void {
        Hyprland.dispatch(`workspace ${w}`);
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            root.byMonitor = root.groupByMonitor(Hyprland.workspaces.values);
        }
    }
}
