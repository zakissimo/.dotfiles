import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.Singletons
import qs.Singletons.Themes

PanelWindow {
    id: panel

    focusable: false
    visible: false
    implicitHeight: Screen.height
    implicitWidth: Screen.width
    color: "transparent"

    GlobalShortcut {
        name: "increaseBrightness"
        onPressed: {
            Brightness.increase();
        }
    }

    GlobalShortcut {
        name: "decreaseBrightness"
        onPressed: {
            Brightness.decrease();
        }
    }

    Rectangle {
        id: background

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 70
        width: 300
        height: 50
        radius: 20
        color: Colors.base
        border.width: 1
        border.color: Colors.highlightMed

        RowLayout {
            id: row

            spacing: 5

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                margins: 25
            }

            Text {
                id: logo

                color: Colors.text
                font.pixelSize: 30
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
                text: {
                    let icon = "";
                    let volume = Math.round(Brightness.level * 100);
                    if (volume > 75)
                        icon = Icons.brightness["up"];
                    else if (volume > 30)
                        icon = Icons.brightness["mid"];
                    else
                        icon = Icons.brightness["low"];
                    return icon;
                }
            }

            ProgressBar {
                id: bar

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                from: 0
                to: 100
                value: Math.round(Brightness.level * 100)

                background: Rectangle {
                    radius: 5
                    color: Colors.overlay
                    implicitWidth: 200
                    implicitHeight: 15
                }

                contentItem: Rectangle {
                    radius: 5
                    color: Colors.muted
                    width: bar.visualPosition * bar.width
                    height: bar.height
                }

            }

        }

    }

    Timer {
        id: hideTimer

        interval: 1500
        repeat: false
        onTriggered: panel.visible = false
    }

    Connections {
        function onLevelChanged() {
            console.log("level changed");
            panel.visible = true;
            hideTimer.restart();
        }

        target: Brightness
    }

    mask: Region {
        item: background
    }

}
