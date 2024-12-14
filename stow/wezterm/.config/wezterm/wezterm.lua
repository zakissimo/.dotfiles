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

config.font_size = 11
config.bidi_enabled = true
config.font = wezterm.font_with_fallback({
  "FiraCode Nerd Font",
  "Noto Sans Mono CJK SC",
  "Noto Naskh Arabic",
})
config.warn_about_missing_glyphs = true
config.window_background_opacity = 1

config.enable_scroll_bar = false

config.window_padding = {
  left = 15,
  right = 15,
  top = 15,
  bottom = 0,
}

config.freetype_load_target = "HorizontalLcd"

config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.default_cursor_style = "SteadyBlock"
config.hide_mouse_cursor_when_typing = false
config.window_close_confirmation = "NeverPrompt"

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 500 }

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
    mods = "LEADER",
    action = act.ActivateCopyMode,
  },
  {
    key = "Enter",
    mods = "ALT",
    action = act.DisableDefaultAssignment,
  },
  {
    key = "LeftArrow",
    mods = "OPT",
    action = act({ SendString = "\x1bb" }),
  },
  {
    key = "RightArrow",
    mods = "OPT",
    action = act({ SendString = "\x1bf" }),
  },
}

config.colors = {
  selection_fg = "black",
  selection_bg = "#fffacd",

  tab_bar = {
    background = "none",

    active_tab = {
      bg_color = "#2b2042",
      fg_color = "#c0c0c0",

      intensity = "Half",
      underline = "None",
      italic = false,
      strikethrough = false,
    },

    inactive_tab = {
      bg_color = "#1b1032",
      fg_color = "#808080",
    },

    inactive_tab_hover = {
      bg_color = "#3b3052",
      fg_color = "#909090",
      italic = true,
    },

    new_tab = {
      bg_color = "None",
      fg_color = "None",
    },

    new_tab_hover = {
      bg_color = "#3b3052",
      fg_color = "#909090",
      italic = false,
    },
  },
}

wezterm.on("format-tab-title", function(tab)
  return {
    { Text = " " .. tab.active_pane.title .. " " },
  }
end)

return config
