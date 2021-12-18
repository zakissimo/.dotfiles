import os
import socket
import subprocess
from typing import List  # noqa: F401
from libqtile.command import lazy
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen

mod = "mod4"
mod1 = "alt"
mod2 = "control"
terminal = "kitty"
home = os.path.expanduser('~')
prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

colors = []
cache = '/home/zak/.cache/wal/colors'


def load_colors(c):
    with open(c, 'r', encoding='utf8') as file:
        for line in file:
            colors.append(line.strip())

    colors.append('#cccccc')
    colors.append('#565656')
    lazy.reload()


load_colors(cache)

keys = [

    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "Return", lazy.spawn("kitty"), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn("brave"), desc="Launch Brave browser"),
    Key([mod], "d", lazy.spawn("emacs"), desc="Launch Emacs"),
    Key([mod], "e", lazy.spawn("pcmanfm"), desc="Launch Pcmanfm"),

    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Backlight
    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 5")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 5")),

    # Sound
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        "amixer -c 1 sset Master 1- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        "amixer -c 1 sset Master 1+ unmute")),
]

groups = []

group_names = ["y", "u", "i", "o", "p"]

group_labels = ["", "", "", "", ""]

group_layouts = ["max", "tile", "columns", "columns", "bsp"]

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
        Key([mod], i.name, lazy.group[i.name].toscreen(toggle=False)),

        # MOVE WINDOW TO SELECTED WORKSPACE AND FOLLOW MOVED WINDOW TO
        # WORKSPACE
        Key([mod, "shift"], i.name, lazy.window.togroup(
            i.name), lazy.group[i.name].toscreen(toggle=False)),
    ])

# DEFAULT THEME SETTINGS FOR LAYOUTS
layout_theme = {
    "margin": 7,
    "border_width": 2,
    "border_focus": "#808080",
    "border_normal": colors[0]
}

layouts = [
    layout.Max(**layout_theme),
    layout.Bsp(**layout_theme),
    layout.Tile(shift_windows=True, **layout_theme),
    layout.Columns(**layout_theme),
]

widget_defaults = dict(
    font="Lobster",
    fontsize=13,
    foreground=colors[-2]
)

def kekdate():
    return subprocess.check_output(os.path.expanduser(f"{home}/.config/qtile/scripts/kekdate.sh")).decode('utf8').strip()

def kektime():
    return subprocess.check_output(os.path.expanduser(f"{home}/.config/qtile/scripts/kektime.sh")).decode('utf8').strip()

def time4salat():
    return subprocess.check_output(os.path.expanduser(f"{home}/.config/qtile/scripts/Time4Salat.py")).decode('utf8').strip()

def kekvolume():
    return subprocess.check_output(os.path.expanduser(f"{home}/.config/qtile/scripts/kekvolume.sh")).decode('utf8').strip()


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    font="FontAwesome",
                    fontsize=15,
                    inactive=colors[-1],
                    active=colors[-2],
                    highlight_method="line",
                    this_current_screen_border=colors[2]
                ),
                widget.Prompt(prompt=prompt),
                widget.WindowName(),
                widget.TextBox("〱", padding=-5, foreground=colors[-1], fontsize=25),
                widget.TextBox("🕋", padding=0, foreground=colors[6], font="FontAwesome", fontsize=13),
                widget.GenPollText(update_interval=60, padding=5, func=time4salat),
                widget.TextBox("〱", padding=-5, foreground=colors[-1], fontsize=25),
                widget.Volume(padding=-1, emoji=True, foreground=colors[6], fontsize=13),
                widget.Volume(padding=5),
                widget.TextBox("〱", padding=-5, foreground=colors[-1], fontsize=25),
                widget.TextBox("📆", padding=0, foreground=colors[6], font="FontAwesome", fontsize=13),
                widget.GenPollText(update_interval=1, padding=5, func=kekdate),
                widget.TextBox("〱", padding=-5, foreground=colors[-1], fontsize=25),
                widget.TextBox("🕒", padding=0, foreground=colors[6], font="FontAwesome", fontsize=15),
                widget.GenPollText(update_interval=1, padding=5, func=kektime),
                widget.TextBox("〱", padding=-5, foreground=colors[-1], fontsize=25),
                widget.BatteryIcon(padding=-5),
                widget.Systray(),
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
        [mod],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click(
        [mod],
        "Button2",
        lazy.window.bring_to_front()),
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
        # Run the utility of `xprop` to see the wm class and name of an X
        # client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirm'),
        Match(wm_class='display'),
        Match(wm_class='dialog'),
        Match(wm_class='download'),
        Match(wm_class='error'),
        Match(wm_class='file_progress'),
        Match(wm_class='notification'),
        Match(wm_class='splash'),
        Match(wm_class='toolbar'),
        Match(wm_class='DBeaver'),
        Match(wm_class='megasync'),

    ])

auto_fullscreen = True
focus_on_window_activation = "smart"


@hook.subscribe.startup_once
def start_once():
    subprocess.call(f'{home}/.config/qtile/autostart.sh')


# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
