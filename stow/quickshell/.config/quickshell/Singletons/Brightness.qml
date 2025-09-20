pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real level: 0
    property real maxBrightness: 0

    function increase(): void {
        getMaxBrightnessCmd.running = true;
        setBrightnessCmd.command = ["brightnessctl", "-e", "s", "+5%"];
        setBrightnessCmd.running = true;
    }

    function decrease(): void {
        getMaxBrightnessCmd.running = true;
        setBrightnessCmd.command = ["brightnessctl", "-e", "s", "5%-"];
        setBrightnessCmd.running = true;
    }

    Process {
        id: getBrightnessCmd
        running: false
        command: ["brightnessctl", "g"]

        stdout: SplitParser {
            onRead: data => {
                root.level = parseInt(data.trim()) / root.maxBrightness;
            }
        }
    }

    Process {
        id: getMaxBrightnessCmd
        running: false
        command: ["brightnessctl", "m"]

        stdout: SplitParser {
            onRead: data => {
                root.maxBrightness = parseInt(data.trim());
            }
        }
    }

    Process {
        id: setBrightnessCmd
        running: false

        stdout: SplitParser {
            onRead: data => {
                getBrightnessCmd.running = true;
            }
        }
    }
}
