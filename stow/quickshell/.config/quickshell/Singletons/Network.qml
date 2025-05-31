pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick

Singleton {
    id: root

    property int vpnActive: 0
    property string connectionType: "none"

    property string downSpeed
    property string upSpeed

    property string oldDownBytes: "0"
    property string oldUpBytes: "0"

    readonly property string downBytesFile: "/tmp/quickshell_down_bytes"
    readonly property string upBytesFile: "/tmp/quickshell_up_bytes"

    function openNetworkEditor() {
        networkEditorCmd.running = true;
    }

    Process {
        id: networkEditorCmd
        command: ["sh", "-c", "nm-connection-editor"]
        running: false
    }

    Process {
        id: networkDownSpeedCmd
        command: ["sh", "-c", `
            current_sum=0
            for bytes in $(cat /sys/class/net/[ew]*/statistics/rx_bytes); do
                current_sum=$((current_sum + bytes))
            done

            if [ -f "${root.downBytesFile}" ]; then
                old_sum=$(cat "${root.downBytesFile}")
                speed=$((current_sum - old_sum))
                echo "$speed"
            else
                echo "0"
            fi

            echo "$current_sum" > "${root.downBytesFile}"
        `]
        running: true
        stdout: SplitParser {
            onRead: data => {
                const speed = parseInt(data.trim()) || 0;
                root.downSpeed = Math.max(0, speed);
            }
        }
    }

    Process {
        id: networkUpSpeedCmd
        command: ["sh", "-c", `
            current_sum=0
            for bytes in $(cat /sys/class/net/[ew]*/statistics/tx_bytes); do
                current_sum=$((current_sum + bytes))
            done

            if [ -f "${root.upBytesFile}" ]; then
                old_sum=$(cat "${root.upBytesFile}")
                speed=$((current_sum - old_sum))
                echo "$speed"
            else
                echo "0"
            fi

            echo "$current_sum" > "${root.upBytesFile}"
        `]
        running: true
        stdout: SplitParser {
            onRead: data => {
                const speed = parseInt(data.trim()) || 0;
                root.upSpeed = Math.max(0, speed);
            }
        }
    }

    Process {
        id: networkTypeCmd

        command: ["sh", "-c", "nmcli -t -f TYPE,STATE d | grep ':connected' | cut -d: -f1"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                const line = data.trim();
                if (line === "wireguard")
                    root.vpnActive = true;
                if (line === "ethernet")
                    root.connectionType = "ethernet";
                else if (line === "wifi")
                    root.connectionType = "wifi";
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            networkTypeCmd.running = true;
            networkDownSpeedCmd.running = true;
            networkUpSpeedCmd.running = true;
        }
    }
}
