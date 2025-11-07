import QtQuick
import QtQuick.Layouts

import qs.Singletons.Themes

Rectangle {
    id: root

    default property alias content: internalRow.children
    property bool clickable: false

    signal clicked

    color: Colors.overlay
    radius: 7
    Layout.preferredHeight: 19
    Layout.preferredWidth: childrenRect.width + 19

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
