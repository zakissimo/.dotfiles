import os
import socket
import subprocess
from typing import List  # noqa: F401
from libqtile.lazy import lazy
from libqtile.widget import backlight
from libqtile.utils import guess_terminal
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen

mod = "mod4"
mod1 = "alt"
mod2 = "control"
terminal = guess_terminal() 
home = os.path.expanduser('~')

colors = []
cache='/home/zak/.cache/wal/colors'

def load_colors(cache):
    with open(cache, 'r') as file:
        for i in range(8):
            colors.append(file.readline().strip())

    colors.append('#ffffff')
    lazy.reload()

load_colors(cache)


keys = [

    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"), 
    Key([mod], "b", lazy.spawn("brave"), desc="Launch Brave browser"),
    Key([mod], "e", lazy.spawn("emacs"), desc="Launch Emacs"),

    # Backlight
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 10")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),
    # Sound
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 1 sset Master 1- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 1 sset Master 1+ unmute")),
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
]

groups = []

group_names = ["y", "u", "i", "o", "p"]

group_labels = ["", "", "", "", ""]

group_layouts = ["max", "tile", "columns", "bsp", "bsp"]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

for i in groups:
    keys.extend([

# CHANGE WORKSPACES
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        Key([mod], "Tab", lazy.screen.next_group()),
        Key([mod, "shift" ], "Tab", lazy.screen.prev_group()),

# MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND FOLLOW MOVED WINDOW TO WORKSPACE
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name) , lazy.group[i.name].toscreen()),
    ])

##### DEFAULT THEME SETTINGS FOR LAYOUTS #####
layout_theme = {
        "margin": 7,
        "border_width": 2,
        "border_focus": "#808080",
        "border_normal": colors[0]
        }

layouts = [
    layout.Bsp(**layout_theme),
    layout.Max(**layout_theme),
    layout.Tile(**layout_theme),
    layout.Columns(**layout_theme),
]

widget_defaults = dict(
    font="Lobster",
    fontsize=17,
    padding=5,
    foreground=colors[4]
)

# extension_defaults = widget_defaults.copy()

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    font = "FontAwesome",
                    fontsize = 15,
                    inactive=colors[1], 
                    active=colors[7],
                    highlight_method = "line",
                    this_current_screen_border = colors[2]
                    ),
                widget.Prompt(prompt = prompt),
                widget.WindowName(),
                widget.Systray(),
                widget.BatteryIcon(padding=3, theme_path='/usr/share/icons/hicolor/scalable/status/'),
                widget.Volume(emoji=True),
                widget.Volume(fontsize=15),
                widget.Clock(foreground=colors[7], format="%H:%M", padding=9),
            ],
            # bar height
            25, background="{0}".format(colors[0])
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
        border_width=3,
        margin=5,
        border_focus="#808080",
        border_normal=colors[0],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        {'wmclass': 'confirm'},
        {'wmclass': 'dialog'},
        {'wmclass': 'download'},
        {'wmclass': 'error'},
        {'wmclass': 'file_progress'},
        {'wmclass': 'notification'},
        {'wmclass': 'splash'},
        {'wmclass': 'toolbar'},
        {'wmclass': 'DBeaver'},
        {'wmclass': 'megasync'},
        ],
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
    
@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"