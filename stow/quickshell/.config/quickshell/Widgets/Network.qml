import "root:/Singletons"
import "root:/Singletons/Themes"

import QtQuick

BarBlock {

    function bytesToMB(bytes, decimals = 2) {
        if (bytes === 0 || isNaN(bytes)) {
            return '0B/s';
        }

        const k = 1024;
        const dm = decimals < 0 ? 0 : decimals;

        const sizes = ['B', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB'];

        const i = Math.floor(Math.log(bytes) / Math.log(k));

        const converted = bytes / Math.pow(k, i);

        let output = isNaN(converted) ? "0.00B/s" : converted.toFixed(dm) + sizes[i] + "/s";

        return output.padStart(11, ' ');
    }

    Text {
        color: Colors.text
        text: Icons.netStatus[Network.vpnActive][Network.connectionType]

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            cursorShape: Qt.PointingHandCursor
            onClicked: mouse => {
                if (mouse.button === Qt.RightButton)
                    Network.openNetworkEditor();
            }
        }
    }

    Text {
        color: Colors.text
        text: {
            let speed = bytesToMB(Network.downSpeed);
            return Icons.arrowDown + speed;
        }
    }

    Text {
        color: Colors.text
        text: {
            let speed = bytesToMB(Network.upSpeed);
            return Icons.arrowUp + speed;
        }
    }
}
