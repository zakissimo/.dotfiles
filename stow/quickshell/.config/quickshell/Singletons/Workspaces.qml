pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root

    property var byMonitor: groupByMonitor(Hyprland.workspaces.values)

    function groupByMonitor(wsList) {
        let monitorMap = {};
        for (let ws of wsList) {
            let monitorId = ws && ws.monitor && ws.monitor.id ? ws.monitor.id : null;
            if (monitorId !== undefined && monitorId !== null) {
                if (!monitorMap[monitorId])
                    monitorMap[monitorId] = [];

                monitorMap[monitorId].push(ws);
            }
        }
        return monitorMap;
    }

    function switchWorkspace(w: int) {
        Hyprland.dispatch(`workspace ${w}`);
    }

    Connections {
        function onRawEvent(event) {
            root.byMonitor = root.groupByMonitor(Hyprland.workspaces.values);
        }

        target: Hyprland
    }
}
