pragma Singleton

import Quickshell

Singleton {
    property string clock: "󱑆 "
    property var clocks: ["󱑊 ", "󱐿 ", "󱑀 ", "󱑁 ", "󱑂 ", "󱑃 ", "󱑄 ", "󱑅 ", "󱑆 ", "󱑇 ", "󱑈 ", "󱑉 "]

    property string calendar: "󰃭 "
    property string usaFlag: " "

    property string kaaba: "󰆦 "

    property string cpu: " "
    property string ram: " "

    property string arrowDown: " "
    property string arrowUp: " "
    property var netStatus: {
        0: {
            "ethernet": "󰈀 ",
            "wifi": "󰤨 ",
            "none": "󰤮 "
        },
        1: {
            "ethernet": " ",
            "wifi": "󰤪 ",
            "none": "󰤮 "
        }
    }

    property var volume: {
        "up": "󰕾 ",
        "mid": "󰖀 ",
        "low": "󰕿 ",
        "muted": "󰝟 "
    }

    property var brightness: {
        "up": "󰃠 ",
        "mid": "󰃟 ",
        "low": "󰃞 "
    }

    property string plug: ""
    property var batteries: ["󰁹 ", "󰂂 ", "󰁿 ", "󰁼 ", "󰁻 ", "󰁺 "]

    property string powerProfile: "󰈐 "
    property var powerProfiles: {
        "power-saver": "󰌪 ",
        "balanced": "󱑰 ",
        "performance": "󱑯 "
    }
}
