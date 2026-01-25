import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
    id: root
    pluginId: "nyTime" // Must match the "id" in metadata.json

    StyledText {
        text: "New-York Time Settings"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
    }
}
