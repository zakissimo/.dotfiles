import QtQuick
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    property string usaFlag: " "

    property string time

    Process {
        id: nyTimeCmd

        environment: ({
                "TZ": "America/New_York"
            })
        command: ["date", "+%H:%M"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                return root.time = data;
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            nyTimeCmd.running = true;
        }
    }

    horizontalBarPill: Component {
        Row {
            spacing: Theme.spacingXS
            rightPadding: Theme.spacingXS
            leftPadding: Theme.spacingXS

            StyledText {
                text: root.usaFlag
                font.family: Theme.fontFamily
                font.pixelSize: Theme.iconSizeSmall - 1
                color: Theme.backgroundText
                anchors.verticalCenter: parent.verticalCenter
            }

            StyledText {
                text: root.time
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSizeSmall - .7
                color: Theme.backgroundText
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                onClicked: {}
            }
        }
    }
}
