import QtQuick
import Quickshell
import Quickshell.Services.Notifications
pragma Singleton

Singleton {
    // signal dismissed(id: int)
    // // readonly property alias notifList: notificationServer.trackedNotifications
    // readonly property alias server: notificationServer

    id: root

    signal incoming(Notification n)

    NotificationServer {
        // n.closed.connect(() => {
        //     root.dismissed(n.id);
        // });

        id: notificationServer

        actionIconsSupported: true
        actionsSupported: true
        imageSupported: true
        onNotification: (n) => {
            n.tracked = true;
            root.incoming(n);
        }
    }

}
