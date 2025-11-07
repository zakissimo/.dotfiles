import QtQuick

import qs.Singletons
import qs.Singletons.Themes

BarBlock {
    Text {
        id: powerIcon

        color: Colors.text
        text: Icons.powerProfiles[PowerManagement.powerProfileStatus] ?? ""
        visible: powerIcon.width

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: PowerManagement.switchProfile()
            cursorShape: Qt.PointingHandCursor
        }
    }

    Text {
        color: Colors.text
        text: {
            if (PowerManagement.batteryStatus === "Full" || PowerManagement.batteryStatus === "Not charging") {
                return Icons.plug;
            } else if (PowerManagement.batteryStatus === "Charging") {
                return Icons.plug + " (" + PowerManagement.batteryCapacity + "%)";
            } else if (PowerManagement.batteryStatus === "Discharging") {
                const percentage = parseInt(PowerManagement.batteryCapacity);
                if (percentage >= 90)
                    return Icons.batteries[0] + " (" + percentage + "%)";
                else if (percentage >= 70)
                    return Icons.batteries[1] + " (" + percentage + "%)";
                else if (percentage >= 50)
                    return Icons.batteries[2] + " (" + percentage + "%)";
                else if (percentage >= 30)
                    return Icons.batteries[3] + " (" + percentage + "%)";
                else if (percentage >= 10)
                    return Icons.batteries[4] + " (" + percentage + "%)";
                else
                    return Icons.batteries[5] + " (" + percentage + "%)";
            } else {
                return Icons.batteries[5] + " (" + PowerManagement.batteryCapacity + "%)";
            }
        }
    }
}
