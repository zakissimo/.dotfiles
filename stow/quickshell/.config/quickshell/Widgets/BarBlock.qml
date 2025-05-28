import QtQuick
import QtQuick.Layouts

import "../Singletons/Themes"

Rectangle {
    color: Colors.overlay
    radius: 7
    Layout.preferredHeight: 19
    Layout.preferredWidth: childrenRect.width + 19

    default property alias content: internalRow.children

    RowLayout {
        id: internalRow
        anchors.centerIn: parent
        spacing: 10
    }
}
