import qs.Singletons
import qs.Singletons.Themes

import Quickshell

import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: panel

    color: "transparent"

    focusable: false
    visible: false

    implicitHeight: Screen.height
    implicitWidth: Screen.width

    anchors {
        top: true
        right: true
    }

    Component.onCompleted: {
        Notifications.incoming.connect(n => {
            if (!n.lastGeneration) {
                panel.showNotification(n);
            }
        });
    }

    function showNotification(n) {
        background.notification = n;
        panel.visible = true;
        dismissTimer.restart();
    }

    function hideNotification() {
        panel.visible = false;
        background.notification = null;
        dismissTimer.stop();
    }

    Rectangle {
        id: background
        visible: panel.visible
        radius: 7
        color: Colors.base
        border.width: 1
        border.color: Colors.highlightMed
        width: 450
        height: 100

        anchors.topMargin: 10
        anchors.rightMargin: 10
        anchors.right: parent.right
        anchors.top: parent.top

        property var notification

        Timer {
            id: dismissTimer
            interval: 2000
            running: false
            repeat: false
            onTriggered: panel.hideNotification()
        }

        MouseArea {
            anchors.fill: parent
            onClicked: panel.hideNotification()
        }

        RowLayout {
            id: content

            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Image {
                source: background.notification && background.notification.appIcon !== "" ? Apps.getIcon(background.notification.appIcon) : Apps.getIcon("application-default-icon")
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: 64
                Layout.preferredHeight: 64
                fillMode: Image.PreserveAspectFit
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Text {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.topMargin: 5

                    text: background.notification ? background.notification.appName : ""
                    font.bold: true
                    color: Colors.text
                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                }

                Text {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    text: background.notification ? background.notification.body : ""
                    color: Colors.text
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                }
            }
        }
    }

    mask: Region {
        item: background
    }
}
