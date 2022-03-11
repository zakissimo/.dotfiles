import os, json
import subprocess
from typing import List
from libqtile.command import lazy
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from scripts.my_widgets import (
    kekram,
    kekdate,
    kektime,
    time4salat,
    monitor_num,
)


mod = "mod4"
alt = "mod1"
terminal = "kitty"
home = os.path.expanduser("~")

colors = os.path.expanduser("~/.cache/wal/colors.json")
with open(colors, "r", encoding="UTF8") as colors:
    colordict = json.load(colors)
    ColorZ = colordict["colors"]["color0"]
    ColorA = colordict["colors"]["color1"]
    ColorB = colordict["colors"]["color2"]
    ColorC = colordict["colors"]["color3"]
    ColorD = colordict["colors"]["color4"]
    ColorE = colordict["colors"]["color5"]
    ColorF = colordict["colors"]["color6"]
    ColorG = colordict["colors"]["color7"]
    ColorH = colordict["colors"]["color8"]
    ColorI = colordict["colors"]["color9"]

background = ColorZ
ext_col = ColorA
int_col = ColorH
active = "#FBF5F3"
inactive = "#6E6C7E"


@lazy.function
def increase_gaps(qtile):
    qtile.current_layout.margin += 10
    qtile.current_group.layout_all()


@lazy.function
def decrease_gaps(qtile):
    qtile.current_layout.margin -= 10
    qtile.current_group.layout_all()


keys = [
    Key([mod, alt], "j", increase_gaps(), desc=""),
    Key([mod, alt], "k", decrease_gaps(), desc=""),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "r", lazy.spawn("rofi -show drun")),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "Return", lazy.spawn("kitty"), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn("brave"), desc="Launch Brave browser"),
    Key([mod], "d", lazy.spawn("emacs"), desc="Launch Emacs"),
    Key([mod], "e", lazy.spawn("pcmanfm"), desc="Launch Pcmanfm"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Switch focus to specific monitor
    Key([mod], "a", lazy.to_screen(0), desc="Keyboard focus to monitor 1"),
    Key([mod], "z", lazy.to_screen(1), desc="Keyboard focus to monitor 2"),
    # Switch focus of monitors
    Key([mod], "space", lazy.next_screen(), desc="Move focus to next monitor"),
    Key([], "Print", lazy.spawn("flameshot gui -c"), desc="Print screen"),
]


if monitor_num() != "1":
    groups = [
        Group("y", label="", layout="max"),
        Group("u", label="", layout="columns"),
        Group("i", label="", layout="columns"),
        Group("o", label="", layout="tile"),
        Group("p", label="", layout="floating"),
        Group("minus", label="", layout="max"),
        Group("egrave", label="", layout="columns"),
        Group("underscore", label="", layout="columns"),
        Group("ccedilla", label="", layout="tile"),
        Group("agrave", label="", layout="bsp"),
    ]
else:
    groups = [
        Group("y", label="", layout="max"),
        Group("u", label="", layout="columns"),
        Group("i", label="", layout="columns"),
        Group("o", label="", layout="tile"),
        Group("p", label="", layout="floating"),
    ]


def go_to_screen(s):
    if s in "yuiop":
        return 0
    return 1


for i in groups:
    keys.extend(
        [
            # CHANGE WORKSPACES
            Key(
                [mod],
                i.name,
                lazy.to_screen(go_to_screen(i.name)),
                lazy.group[i.name].toscreen(go_to_screen(i.name), toggle=False),
            ),
            # MOVE WINDOW TO SELECTED WORKSPACE AND FOLLOW MOVED WINDOW TO
            # WORKSPACE
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                lazy.to_screen(go_to_screen(i.name)),
                lazy.group[i.name].toscreen(go_to_screen(i.name), toggle=False),
            ),
        ]
    )

# DEFAULT THEME SETTINGS FOR LAYOUTS
layout_theme = {
    "margin": 7,
    "border_width": 1,
    "border_focus": ext_col,
    "border_normal": background,
}

layouts = [
    layout.Max(**layout_theme),
    layout.Columns(**layout_theme),
    layout.Stack(num_stacks=3, margin=190, border_width=2),
    layout.Bsp(**layout_theme),
    layout.Tile(shift_windows=True, **layout_theme),
    layout.Floating(border_width=0),
]

widget_defaults = dict(
    font="CaskaydiaCove Nerd Font",
    fontsize=12,
    foreground=active,
    background=background,
)


def init_widgets_list():
    return [
        widget.TextBox(
            font="Fira Mono",
            text="\ue0ba",
            padding=-1,
            foreground=background,
            background=ext_col,
            fontsize=35,
        ),
        widget.GroupBox(
            font="Fira Mono",
            fontsize=25,
            inactive=inactive,
            active=active,
            highlight_method="line",
            this_current_screen_border=ext_col,
            visible_groups=["y", "u", "i", "o", "p"],
        ),
        widget.GroupBox(
            font="Fira Mono",
            fontsize=25,
            active=active,
            inactive=inactive,
            highlight_method="line",
            this_current_screen_border=ext_col,
            visible_groups=["minus", "egrave", "underscore", "ccedilla", "agrave"],
        ),
        widget.TextBox(
            font="Fira Mono",
            text="\uE0Ba",
            padding=-1,
            foreground=ext_col,
            background=background,
            fontsize=35,
        ),
        widget.WindowName(foreground=active, background=ext_col),
        widget.TextBox(
            font="Fira Mono",
            text="\uE0Ba",
            padding=-1,
            foreground=background,
            background=ext_col,
            fontsize=35,
        ),
        widget.GenPollText(
            update_interval=1,
            padding=0,
            background=background,
            mouse_callbacks={"Button1": lazy.spawn("kitty -e btop")},
            func=kekram,
        ),
        widget.Net(format="↓ {down} ↑ {up}", background=background),
        widget.TextBox(
            font="Fira Mono",
            text="\ue0ba",
            padding=-1,
            foreground=int_col,
            background=background,
            fontsize=35,
        ),
        widget.GenPollText(
            update_interval=60, padding=0, background=int_col, func=time4salat
        ),
        widget.TextBox(
            font="Fira Mono",
            text="\uE0Ba",
            padding=-1,
            foreground=ext_col,
            background=int_col,
            fontsize=35,
        ),
        widget.GenPollText(
            update_interval=3600,
            padding=0,
            background=ext_col,
            mouse_callbacks={"Button1": lazy.spawn("kitty -e cal")},
            func=kekdate,
        ),
        widget.TextBox(
            font="Fira Mono",
            text="\uE0Ba",
            padding=-1,
            foreground=int_col,
            background=ext_col,
            fontsize=35,
        ),
        widget.GenPollText(
            update_interval=60, background=int_col, padding=0, func=kektime
        ),
        widget.TextBox(
            font="Fira Mono",
            text="\ue0ba",
            padding=-1,
            foreground=background,
            background=int_col,
            fontsize=35,
        ),
        widget.Systray(),
        widget.TextBox(
            font="Fira Mono",
            text="\ue0ba",
            padding=-3,
            foreground=ext_col,
            background=background,
            fontsize=35,
        ),
    ]


def init_widgets_screen1():
    w = init_widgets_list()
    del w[2]
    return w


def init_widgets_screen2():
    w = init_widgets_list()
    # Removing unwanted widgets (systray) on Monitor 2
    del w[1]
    del w[5:]
    return w


def init_screens():
    screen_one = bar.Bar(
        widgets=init_widgets_screen1(),
        background=background,
        opacity=1.0,
        size=23,
        # margin=5,
        border_width=[7, 5, 7, 5],
        border_color=[
            background,
            ext_col,
            background,
            ext_col,
        ],
    )
    screen_two = bar.Bar(
        widgets=init_widgets_screen2(),
        background=background,
        opacity=1.0,
        size=23,
        # margin=5,
        border_width=[7, 5, 7, 5],
        border_color=[
            background,
            background,
            background,
            ext_col,
        ],
    )
    if monitor_num() != "1":
        return [
            Screen(screen_one),
            Screen(screen_two),
        ]
    return [
        Screen(screen_one),
    ]


if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()


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


floating_layout = layout.Floating(
    border_width=3,
    margin=5,
    border_focus=ext_col,
    border_normal=background,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X
        # client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirm"),
        Match(wm_class="display"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="file_progress"),
        Match(wm_class="notification"),
        Match(wm_class="splash"),
        Match(wm_class="toolbar"),
        Match(wm_class="DBeaver"),
        Match(wm_class="megasync"),
        Match(wm_class="PlayOnLinux"),
        Match(wm_class="EasyEffects"),
        Match(wm_class="Vmplayer"),
    ],
)


@hook.subscribe.startup_once
def start_once():
    subprocess.call(f"{home}/.config/qtile/scripts/autostart.sh")


auto_fullscreen = True
focus_on_window_activation = "smart"
dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_minimize = True
wmname = "LG3D"
