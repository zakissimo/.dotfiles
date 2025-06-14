import "root:/Singletons"
import "root:/Singletons/Themes"

import QtQuick

BarBlock {

    Text {
        color: Colors.text
        text: Icons.clocks[parseInt(Time.local.substring(0, 2)) % 12] + Time.local
    }

    Text {
        color: Colors.text
        text: Icons.usaFlag + Time.ny
    }

    Text {
        color: Colors.text
        text: Icons.kaaba + Time.salat
    }
}
