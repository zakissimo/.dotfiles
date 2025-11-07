import QtQuick

import qs.Singletons
import qs.Singletons.Themes

BarBlock {
    Text {
        color: Colors.text
        text: Icons.cpu + Resources.cpu.padStart(4, ' ') + "%"
    }

    Text {
        color: Colors.text
        text: Icons.ram + Resources.ram.padStart(4, ' ') + "%"
    }
}
