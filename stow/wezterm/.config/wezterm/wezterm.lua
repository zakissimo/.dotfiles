local wezterm = require("wezterm")

local act = wezterm.action

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.audible_bell = "Disabled"

config.term = "xterm"

config.color_scheme = "rose-pine"

config.enable_wayland = false

config.window_decorations = "RESIZE"

config.font_size = 15
config.bidi_enabled = true
config.font = wezterm.font_with_fallback({
    "FiraCode Nerd Font",
    "Noto Sans Mono CJK SC",
    "Noto Naskh Arabic",
})
config.warn_about_missing_glyphs = false
config.window_background_opacity = 0.9
config.macos_window_background_blur = 99

config.enable_scroll_bar = false

config.window_padding = {
    left = "1%",
    right = "1%",
    top = "0.5%",
    bottom = "0.3%",
}

config.freetype_load_target = "HorizontalLcd"

config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.default_cursor_style = "SteadyBlock"
config.hide_mouse_cursor_when_typing = false
config.window_close_confirmation = "NeverPrompt"

local function macCMDtoMeta()
    local keys = "abdefghijklmnopqrstuwxyz" -- no c,v
    local keymappings = {}

    for i = 1, #keys do
        local c = keys:sub(i, i)
        table.insert(keymappings, {
            key = c,
            mods = "CMD",
            action = act.SendKey({
                key = c,
                mods = "META",
            }),
        })
        table.insert(keymappings, {
            key = c,
            mods = "CMD|CTRL",
            action = act.SendKey({
                key = c,
                mods = "META|CTRL",
            }),
        })
    end
    return keymappings
end

config.keys = macCMDtoMeta()

return config
