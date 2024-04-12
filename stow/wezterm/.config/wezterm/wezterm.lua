local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.audible_bell = "Disabled"

config.term = "wezterm"

config.color_scheme = "rose-pine"

config.enable_wayland = false

config.font_size = 15
config.bidi_enabled = true
config.font = wezterm.font_with_fallback({
    "FiraCode Nerd Font",
    "Noto Sans Mono CJK SC",
    "Noto Naskh Arabic",
})
config.warn_about_missing_glyphs = false
config.window_background_opacity = 0.95

config.window_padding = {
    left = 5,
    right = 0,
    top = 25,
    bottom = 0,
}

config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.default_cursor_style = "SteadyBlock"
config.hide_mouse_cursor_when_typing = false
config.window_close_confirmation = "NeverPrompt"

config.keys = {
    {
        key = "w",
        mods = "ALT",
        action = act.CloseCurrentTab({ confirm = false }),
    },
    {
        key = "l",
        mods = "ALT",
        action = act.ActivateTabRelative(1),
    },
    {
        key = "h",
        mods = "ALT",
        action = act.ActivateTabRelative(-1),
    },
    {
        key = "n",
        mods = "ALT",
        action = act.SpawnTab("DefaultDomain"),
    },
    {
        key = "Space",
        mods = "ALT",
        action = act.ActivateCopyMode,
    },
    {
        key = "Enter",
        mods = "ALT",
        action = act.DisableDefaultAssignment,
    },
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {
        key = "LeftArrow",
        mods = "OPT",
        action = act({ SendString = "\x1bb" }),
    },
    -- Make Option-Right equivalent to Alt-f; forward-word
    {
        key = "RightArrow",
        mods = "OPT",
        action = act({ SendString = "\x1bf" }),
    },
}

config.colors = {
    tab_bar = {
        -- The color of the strip that goes along the top of the window
        -- (does not apply when fancy tab bar is in use)
        background = "none",

        -- The active tab is the one that has focus in the window
        active_tab = {
            -- The color of the background area for the tab
            bg_color = "#2b2042",
            -- The color of the text for the tab
            fg_color = "#c0c0c0",

            -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
            -- label shown for this tab.
            -- The default is "Normal"
            intensity = "Half",

            -- Specify whether you want "None", "Single" or "Double" underline for
            -- label shown for this tab.
            -- The default is "None"
            underline = "None",

            -- Specify whether you want the text to be italic (true) or not (false)
            -- for this tab.  The default is false.
            italic = false,

            -- Specify whether you want the text to be rendered with strikethrough (true)
            -- or not for this tab.  The default is false.
            strikethrough = false,
        },

        -- Inactive tabs are the tabs that do not have focus
        inactive_tab = {
            bg_color = "#1b1032",
            fg_color = "#808080",

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `inactive_tab`.
        },

        -- You can configure some alternate styling when the mouse pointer
        -- moves over inactive tabs
        inactive_tab_hover = {
            bg_color = "#3b3052",
            fg_color = "#909090",
            italic = true,

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `inactive_tab_hover`.
        },

        -- The new tab button that let you create new tabs
        new_tab = {
            bg_color = "None",
            fg_color = "None",

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `new_tab`.
        },

        -- You can configure some alternate styling when the mouse pointer
        -- moves over the new tab button
        new_tab_hover = {
            bg_color = "#3b3052",
            fg_color = "#909090",
            italic = false,

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `new_tab_hover`.
        },
    },
}

wezterm.on("format-tab-title", function(tab)
    return {
        { Text = " " .. tab.active_pane.title .. " " },
    }
end)

return config
