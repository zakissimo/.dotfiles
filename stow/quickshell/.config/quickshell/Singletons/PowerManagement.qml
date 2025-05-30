pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick

Singleton {
    id: root

    property string batteryStatus
    property string batteryCapacity
    property string powerProfileStatus

    property list<string> powerProfiles: ["power-saver", "balanced", "performance"]

    function switchProfile(): void {
        let index = (powerProfiles.indexOf(powerProfileStatus) + 1) % powerProfiles.length;
        setPowerProfileCmd.command = ["sh", "-c", `powerprofilesctl set ${powerProfiles[index]}`];
    }

    Process {
        id: statusCmd

        command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/status"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                root.batteryStatus = data;
            }
        }
    }

    Process {
        id: capacityCmd

        command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/capacity"]
        running: true

        stdout: SplitParser {
            onRead: data => root.batteryCapacity = data
        }
    }

    Process {
        id: getPowerProfileCmd

        command: ["sh", "-c", "powerprofilesctl get"]
        running: true

        stdout: SplitParser {
            onRead: data => root.powerProfileStatus = data
        }
    }

    Process {
        id: setPowerProfileCmd

        command: []

        onCommandChanged: setPowerProfileCmd.running = true
        onRunningChanged: getPowerProfileCmd.running = true
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            statusCmd.running = true;
            capacityCmd.running = true;
        }
    }
}
