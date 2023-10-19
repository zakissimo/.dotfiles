local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.term = "xterm-256color"

-- config.color_scheme = 'Tokyo Night (Gogh)'
config.color_scheme = "rose-pine"

config.font_size = 17
config.bidi_enabled = true
config.font = wezterm.font_with_fallback({
    "FiraCode Nerd Font",
    "JetBrainsMono Nerd Font",
    "CaskaydiaCove NF",
    "Ubuntu Mono Ligaturized",
    "Noto Sans Mono CJK SC",
})
config.warn_about_missing_glyphs = false
config.window_background_opacity = 0.75

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.enable_tab_bar = false
config.default_cursor_style = "SteadyBlock"
config.hide_mouse_cursor_when_typing = false
config.window_close_confirmation = "NeverPrompt"

config.keys = {
    {
        key = "Enter",
        mods = "ALT",
        action = wezterm.action.DisableDefaultAssignment,
    },
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {
        key = "LeftArrow",
        mods = "OPT",
        action = wezterm.action({ SendString = "\x1bb" }),
    },
    -- Make Option-Right equivalent to Alt-f; forward-word
    {
        key = "RightArrow",
        mods = "OPT",
        action = wezterm.action({ SendString = "\x1bf" }),
    },
}

return config
