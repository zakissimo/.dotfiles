pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    signal incoming(Notification n)

    NotificationServer {
        id: notificationServer

        actionIconsSupported: true
        actionsSupported: true
        imageSupported: true
        onNotification: n => {
            n.tracked = true;
            root.incoming(n);
        }
    }
}
