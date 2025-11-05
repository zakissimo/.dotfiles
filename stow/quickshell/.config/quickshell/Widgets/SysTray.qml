import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

RowLayout {
    spacing: 5

    Repeater {
        id: repeater

        model: SystemTray.items

        MouseArea {
            id: delegate

            required property SystemTrayItem modelData
            property alias item: delegate.modelData

            Layout.fillHeight: true
            implicitWidth: icon.implicitWidth + 5
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
            hoverEnabled: true
            onClicked: (event) => {
                if (event.button == Qt.LeftButton)
                    item.activate();
                else if (event.button == Qt.MiddleButton)
                    item.secondaryActivate();
                else if (event.button == Qt.RightButton)
                    menuAnchor.open();
            }
            onWheel: (event) => {
                event.accepted = true;
                const points = event.angleDelta.y / 120;
                item.scroll(points, false);
            }

            IconImage {
                id: icon

                anchors.centerIn: parent
                source: delegate.item.icon
                implicitSize: 16
            }

            QsMenuAnchor {
                id: menuAnchor

                menu: delegate.item.menu
                anchor.window: delegate.QsWindow.window
                anchor.adjustment: PopupAdjustment.Flip
                anchor.onAnchoring: {
                    const window = delegate.QsWindow.window;
                    const widgetRect = window.contentItem.mapFromItem(delegate, 0, delegate.height, delegate.width, delegate.height);
                    menuAnchor.anchor.rect = widgetRect;
                }
            }

        }

    }

}
