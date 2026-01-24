import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
    id: root
    pluginId: "timeForSalat" // Must match the "id" in metadata.json

    StyledText {
        text: "Prayer Times Settings"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
    }

    StyledText {
        text: "Settings for Mawaqit / Salat integration"
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
    }
}
