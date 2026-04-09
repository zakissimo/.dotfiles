import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
    id: root
    pluginId: "timeForSalat"

    property var locations: root.loadValue("locations", [])
    property string activeSlug: root.loadValue("slug", "")

    StyledText {
        text: "Prayer Times Settings"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
    }

    StyledText {
        text: "Add a new location"
        font.pixelSize: Theme.fontSizeMedium
        font.weight: Font.Bold
    }

    StringSetting {
        id: nameField
        settingKey: "_addName"
        label: "Label"
        placeholder: "e.g. Home, Work..."
    }

    StringSetting {
        id: slugField
        settingKey: "_addSlug"
        label: "Mosque slug"
        description: "e.g. al-fourqaan-moskee-eindhoven-eindhoven-5622-al-netherlands"
        placeholder: "Enter mosque slug"
    }

    DankButton {
        text: "Add location"
        iconName: "add"
        onClicked: {
            if (slugField.value === "" || nameField.value === "") return;
            let label = nameField.value;
            let list = root.locations.slice();
            list.push({ name: label, slug: slugField.value });
            root.locations = list;
            root.saveValue("locations", list);
            nameField.value = "";
            slugField.value = "";
        }
    }

    StyledText {
        text: "Saved locations"
        font.pixelSize: Theme.fontSizeMedium
        font.weight: Font.Bold
        visible: locationRepeater.count > 0
    }

    Column {
        width: parent.width
        spacing: Theme.spacingXS

        Repeater {
            id: locationRepeater
            model: root.locations

            StyledRect {
                width: parent.width
                height: locationRow.implicitHeight + Theme.spacingS * 2
                color: Theme.surfaceContainerHigh
                radius: Theme.cornerRadius

                Row {
                    id: locationRow
                    anchors.fill: parent
                    anchors.margins: Theme.spacingS
                    spacing: Theme.spacingS

                    DankIcon {
                        name: modelData.slug === root.activeSlug ? "radio_button_checked" : "radio_button_unchecked"
                        size: Theme.iconSize
                        color: modelData.slug === root.activeSlug ? Theme.primary : Theme.surfaceVariantText
                        anchors.verticalCenter: parent.verticalCenter

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.activeSlug = modelData.slug;
                                root.saveValue("slug", modelData.slug);
                            }
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width - Theme.iconSize * 2 - Theme.spacingS * 3

                        StyledText {
                            text: modelData.name
                            font.pixelSize: Theme.fontSizeMedium
                            font.weight: Font.Bold
                            color: modelData.slug === root.activeSlug ? Theme.primary : Theme.surfaceText
                        }

                        StyledText {
                            text: modelData.slug
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.surfaceVariantText
                            elide: Text.ElideMiddle
                            width: parent.width
                        }
                    }

                    DankActionButton {
                        iconName: "delete"
                        iconColor: Theme.error
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            let list = root.locations.filter((_, i) => i !== index);
                            root.locations = list;
                            root.saveValue("locations", list);
                            if (modelData.slug === root.activeSlug) {
                                root.activeSlug = "";
                                root.saveValue("slug", "");
                            }
                        }
                    }
                }
            }
        }
    }
}
