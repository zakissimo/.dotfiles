import QtQuick

import qs.Singletons
import qs.Singletons.Themes
import qs.Widgets.TextVariants

BarBlock {
    Body {
        color: Colors.text
        text: Icons.clocks[parseInt(Time.local.substring(0, 2)) % 12] + Time.local
    }

    Body {
        color: Colors.text
        text: Icons.usaFlag + Time.ny
    }

    Body {
        color: Colors.text
        text: Icons.kaaba + Time.salat
    }
}
