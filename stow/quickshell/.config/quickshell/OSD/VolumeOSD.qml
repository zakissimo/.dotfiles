import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland

import qs.Singletons
import qs.Singletons.Themes
import qs.Widgets.TextVariants

PanelWindow {
    id: panel

    focusable: false
    visible: false
    implicitHeight: Screen.height
    implicitWidth: Screen.width
    color: "transparent"

    GlobalShortcut {
        name: "increaseVolume"
        onPressed: {
            Audio.increaseVolume();
        }
    }

    GlobalShortcut {
        name: "decreaseVolume"
        onPressed: {
            Audio.decreaseVolume();
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

            spacing: -10

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                margins: 25
            }

            Body {
                id: logo

                color: Colors.text
                font.pixelSize: 40
                verticalAlignment: Text.AlignVCenter
                Layout.alignment: Qt.AlignVCenter
                text: {
                    if (Audio.muted)
                        return Icons.volume["muted"];

                    let icon = "";
                    let volume = Math.round(Audio.volume * 100);
                    if (volume > 75)
                        icon = Icons.volume["up"];
                    else if (volume > 30)
                        icon = Icons.volume["mid"];
                    else
                        icon = Icons.volume["low"];
                    return icon;
                }
            }

            ProgressBar {
                id: bar

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                from: 0
                to: 100
                value: Math.round(Audio.volume * 100)

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
        function onVolumeChanged() {
            panel.visible = true;
            hideTimer.restart();
        }

        function onMutedChanged() {
            panel.visible = true;
            hideTimer.restart();
        }

        target: Audio
    }

    mask: Region {
        item: background
    }
}
