pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick

Singleton {
    id: root
    property string local
    property string ny
    property string salat
    property string date

    Process {
        id: localDateCmd

        command: ["date", "+%a %d %b"]
        running: true

        stdout: SplitParser {
            onRead: data => root.date = data
        }
    }

    Process {
        id: localTimeCmd

        command: ["date", "+%H:%M"]
        running: true

        stdout: SplitParser {
            onRead: data => root.local = data
        }
    }

    Process {
        id: nyTimeCmd
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
            localTimeCmd.running = true;
            nyTimeCmd.running = true;
            salatTimeCmd.running = true;
        }
    }
}
