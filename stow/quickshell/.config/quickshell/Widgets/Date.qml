import "root:/Singletons"
import "root:/Singletons/Themes"

import QtQuick

BarBlock {
    Text {
        color: Colors.text
        text: Icons.calendar + Time.date
    }
}
