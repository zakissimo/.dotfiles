import QtQuick
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    property string kaaba: "󰆦"
    property string salat

    Process {
        id: salatTimeCmd

        command: ["bash", "-c", ". ~/.env && time_for_salat"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                return root.salat = data;
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            salatTimeCmd.running = true;
        }
    }

    horizontalBarPill: Component {
        Row {
            spacing: Theme.spacingXS
            rightPadding: Theme.spacingS
            leftPadding: Theme.spacingS

            StyledText {
                text: root.kaaba
                font.family: Theme.fontFamily
                font.pixelSize: Theme.iconSizeSmall - 1
                font.weight: Font.Small
                color: Theme.backgroundText
                anchors.verticalCenter: parent.verticalCenter
            }

            StyledText {
                text: root.salat
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSizeSmall - .7
                font.weight: Font.Small
                color: Theme.backgroundText
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                onClicked: {}
            }
        }
    }
}
