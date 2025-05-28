pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string local
    property string ny
    property string salat

    Process {
        id: localDateCmd

        command: ["date", "+%H:%M"]
        running: true

        stdout: SplitParser {
            onRead: data => root.local = data
        }
    }

    Process {
        id: nyDateCmd
        environment: ({
                "TZ": "America/New_York"
            })
        command: ["date", "+%H:%M"]
        running: true

        stdout: SplitParser {
            onRead: data => root.ny = data
        }
    }

    Process {
        id: salatTimeCmd
        command: ["time_for_salat"]
        running: true

        stdout: SplitParser {
            onRead: data => root.salat = data
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            localDateCmd.running = true;
            nyDateCmd.running = true;
            salatTimeCmd.running = true;
        }
    }
}
