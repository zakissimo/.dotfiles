import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
    id: root
    pluginId: "timeForSalat"

    StyledText {
        text: "Prayer Times Settings"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
    }

    StyledText {
        text: "Mawaqit mosque slug (e.g. al-fourqaan-moskee-eindhoven-eindhoven-5622-al-netherlands)"
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
    }

    Row {
        width: parent.width
        spacing: Theme.spacingS

        TextField {
            id: slugField
            width: parent.width - applyButton.width - Theme.spacingS
            text: root.loadValue("slug", "")
            placeholderText: "Enter mosque slug"
        }

        DankButton {
            id: applyButton
            text: "Apply"
            iconName: "check"
            anchors.verticalCenter: slugField.verticalCenter
            onClicked: root.saveValue("slug", slugField.text)
        }
    }
}
