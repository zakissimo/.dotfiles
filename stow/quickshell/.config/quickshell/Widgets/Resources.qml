import QtQuick

import qs.Singletons
import qs.Singletons.Themes
import qs.Widgets.TextVariants

BarBlock {
    Body {
        color: Colors.text
        text: Icons.cpu + Resources.cpu.padStart(4, ' ') + "%"
    }

    Body {
        color: Colors.text
        text: Icons.ram + Resources.ram.padStart(4, ' ') + "%"
    }
}
