import "root:/Singletons"
import "root:/Singletons/Themes"

import QtQuick

BarBlock {
    Text {
        color: Colors.text
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

            return icon + volume + "%";
        }

        MouseArea {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            onWheel: event => {
                if (event.angleDelta.y > 0)
                    Audio.setVolume(Audio.volume + 0.1);
                else if (event.angleDelta.y < 0)
                    Audio.setVolume(Audio.volume - 0.1);
            }

            onClicked: Audio.toggleMute()
        }
    }
}
