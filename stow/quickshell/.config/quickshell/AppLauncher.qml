import QtQuick
import QtQuick.Controls

import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

import qs.Singletons
import qs.Singletons.Themes

PanelWindow {
    id: panel

    function toggle() {
        panel.visible = !panel.visible;
    }

    function updateFilter(query) {
        filteredModel.clear();
        let apps = Apps.list;
        let q = query ? query.toLowerCase() : "";
        for (let i = 0; i < apps.length; i++) {
            let app = apps[i];
            if (q.length === 0 || app.name.toLowerCase().includes(q) || app.execString.toLowerCase().includes(q))
                filteredModel.append({
                    "name": app.name,
                    "icon": app.icon,
                    "execString": app.execString,
                    "entryObject": app
                });
        }
    }

    WlrLayershell.namespace: "quickshell:search"
    focusable: true
    visible: false
    implicitHeight: Screen.height
    implicitWidth: Screen.width
    color: "transparent"
    onVisibleChanged: {
        if (visible) {
            panel.updateFilter("");
            listView.currentIndex = 0;
        } else {
            textField.clear();
            filteredModel.clear();
        }
    }
    Component.onCompleted: {
        panel.updateFilter("");
    }

    GlobalShortcut {
        name: "search"
        onPressed: {
            panel.toggle();
        }
    }

    MouseArea {
        z: 0
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: function (mouse) {
            if (!background.contains(Qt.point(mouse.x, mouse.y)))
                panel.toggle();
        }
    }

    Rectangle {
        id: background

        z: 1
        anchors.centerIn: parent
        width: 500
        height: 300
        radius: 7
        color: Colors.base
        border.width: 1
        border.color: Colors.highlightMed

        TextField {
            id: textField

            color: Colors.text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 15
            bottomPadding: 0
            focus: true
            font.pixelSize: 16
            height: 40
            leftPadding: searchIcon.visible ? searchIcon.width + 20 : 10
            onTextChanged: panel.updateFilter(textField.text)
            placeholderText: ""
            selectByMouse: true
            topPadding: 0
            width: parent.width - 20
            Keys.onPressed: event => {
                if (event.key === Qt.Key_Up) {
                    if (listView.currentIndex > 0) {
                        listView.currentIndex--;
                        listView.positionViewAtIndex(listView.currentIndex, ListView.Visible);
                    }
                    event.accepted = true;
                } else if (event.key === Qt.Key_Down) {
                    if (listView.currentIndex < filteredModel.count - 1) {
                        listView.currentIndex++;
                        listView.positionViewAtIndex(listView.currentIndex, ListView.Visible);
                    }
                    event.accepted = true;
                } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    if (listView.currentIndex >= 0 && listView.currentIndex < filteredModel.count) {
                        const app = filteredModel.get(listView.currentIndex).entryObject;
                        Apps.launch(app);
                        panel.toggle();
                    } else if (listView.currentIndex === -1) {
                        Apps.exec(text);
                        panel.toggle();
                    }
                    event.accepted = true;
                } else if ((event.key === Qt.Key_Escape) || (event.key === Qt.Key_BracketLeft && event.modifiers & Qt.ControlModifier)) {
                    panel.toggle();
                    event.accepted = true;
                } else {
                    event.accepted = false;
                }
            }
            onActiveFocusChanged: {
                if (activeFocus)
                    selectAll();
            }

            Text {
                id: searchIcon

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: "\uf002"
                font.pixelSize: 18
                color: Colors.highlightMed
            }

            cursorDelegate: Rectangle {
                width: 8
                height: textField.height
                color: Colors.muted
                visible: textField.activeFocus
            }

            background: Rectangle {
                color: Colors.surface
                border.color: Colors.highlightMed
                border.width: 1
                radius: 6
            }
        }

        ListModel {
            id: filteredModel
        }

        Rectangle {
            id: listViewBackground

            anchors.top: textField.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 9
            color: Colors.surface
            radius: 4
            border.width: 2
            border.color: Colors.base

            ListView {
                id: listView

                anchors.fill: parent
                anchors.margins: 2
                clip: true
                model: filteredModel

                delegate: Rectangle {
                    id: delegate

                    required property string name
                    required property string icon

                    width: ListView.view.width
                    height: 35
                    color: ListView.isCurrentItem ? Colors.highlightMed : "transparent"
                    radius: 2

                    Row {
                        anchors.fill: parent
                        anchors.margins: 6
                        spacing: 10

                        Image {
                            source: Apps.getIcon(delegate.icon)
                            width: 24
                            height: 24
                        }

                        Text {
                            text: delegate.name
                            color: Colors.text
                        }
                    }
                }
            }
        }
    }
}
