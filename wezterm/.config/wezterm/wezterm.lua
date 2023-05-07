local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.term = "xterm-256color"

-- config.color_scheme = 'Tokyo Night (Gogh)'
config.color_scheme = 'rose-pine'

config.font_size = 17
config.bidi_enabled = false
config.font = wezterm.font_with_fallback {
    'FiraCode Nerd Font',
    'JetBrainsMono Nerd Font',
    'CaskaydiaCove NF',
    'Ubuntu Mono Ligaturized',
    'Noto Sans Mono CJK SC',
}
config.warn_about_missing_glyphs = true
config.window_background_opacity = 0.75

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.enable_tab_bar = false
config.default_cursor_style = 'SteadyBlock'
config.hide_mouse_cursor_when_typing = false

config.keys = {
    {
        key = 'Enter',
        mods = 'ALT',
        action = wezterm.action.DisableDefaultAssignment,
    }
}

return config
