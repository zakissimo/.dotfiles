pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string cpu: "0.0"
    property string ram: "0.0"

    Process {
        id: cpuCmd

        command: ["sh", "-c", "top -bn2 | grep \"Cpu(s)\" | awk '{print 100 - $8}'"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const cpuValue = parseFloat(data.trim());
                if (!isNaN(cpuValue))
                    root.cpu = cpuValue.toFixed(1);
                else
                    root.cpu = "0.0";
            }
        }
    }

    Process {
        id: ramCmd

        command: ["sh", "-c", "free | awk '/Mem/ { print ($3/$2) * 100 }'"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const ramValue = parseFloat(data.trim());
                if (!isNaN(ramValue))
                    root.ram = ramValue.toFixed(1);
                else
                    root.ram = "0.0";
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            cpuCmd.running = true;
            ramCmd.running = true;
        }
    }
}
