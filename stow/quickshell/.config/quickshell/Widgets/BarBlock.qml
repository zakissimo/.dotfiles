import "root:/Singletons/Themes"

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    // color: "transparent"
    color: Colors.surface
    // color: Qt.rgba(1, 1, 1, 0.1)  // semi-transparent blue
    radius: 7
    Layout.preferredHeight: 19
    Layout.preferredWidth: childrenRect.width + 19

    default property alias content: internalRow.children

    signal clicked

    property bool clickable: false

    MouseArea {
        id: mouseArea

        anchors.centerIn: parent
        height: internalRow.height
        width: internalRow.width

        cursorShape: root.clickable ? Qt.PointingHandCursor : Qt.ArrowCursor
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        onClicked: root.clicked()
    }

    RowLayout {
        id: internalRow
        anchors.centerIn: parent
        spacing: 10
    }
}
