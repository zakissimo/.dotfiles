import os
import json
import subprocess
from typing import List
from libqtile.command import lazy
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.layout.max import Max
from libqtile.layout.bsp import Bsp
from libqtile.layout.floating import Floating
from scripts.my_widgets import (
    kekram,
    kekdate,
    kektime,
    time4salat,
    monitor_num,
)


MOD = "mod4"
ALT = "mod1"
TERMINAL = "kitty"
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
ACTIVE = "#FBF5F3"
INACTIVE = "#6E6C7E"


@lazy.function
def increase_gaps(qtile):
    qtile.current_layout.margin += 5
    qtile.current_group.layout_all()


@lazy.function
def decrease_gaps(qtile):
    qtile.current_layout.margin -= 5
    qtile.current_group.layout_all()


def resize(qtile, direction):
    curr_layout = qtile.current_layout
    child = curr_layout.current
    parent = child.parent

    while parent:
        if child in parent.children:
            layout_all = False

            if (direction == "left" and parent.split_horizontal) or (
                direction == "up" and not parent.split_horizontal
            ):
                parent.split_ratio = max(
                    5, parent.split_ratio - curr_layout.grow_amount)
                layout_all = True
            elif (direction == "right" and parent.split_horizontal) or (
                direction == "down" and not parent.split_horizontal
            ):
                parent.split_ratio = min(
                    95, parent.split_ratio + curr_layout.grow_amount)
                layout_all = True

            if layout_all:
                curr_layout.group.layout_all()
                break

        child = parent
        parent = child.parent


@lazy.function
def resize_left(qtile):
    resize(qtile, "left")


@lazy.function
def resize_right(qtile):
    resize(qtile, "right")


@lazy.function
def resize_up(qtile):
    resize(qtile, "up")


@lazy.function
def resize_down(qtile):
    resize(qtile, "down")


keys = [
    Key([MOD, ALT], "j", increase_gaps, desc=""),
    Key([MOD, ALT], "k", decrease_gaps, desc=""),
    Key([MOD], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([MOD], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([MOD], "j", lazy.layout.down(), desc="Move focus down"),
    Key([MOD], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [MOD, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [MOD, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([MOD, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([MOD, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([MOD, "control"], "h", resize_left, desc="Grow window to the left"),
    Key(
        [MOD, "control"],
        "l",
        resize_right,
        desc="Grow window to the right",
    ),
    Key([MOD, "control"], "j", resize_down, desc="Grow window down"),
    Key([MOD, "control"], "k", resize_up, desc="Grow window up"),
    Key([MOD], "r", lazy.spawn("rofi -show drun")),
    Key([MOD], "space", lazy.layout.next(),
        desc="Move window focus to other window"),
    Key([MOD], "f", lazy.window.toggle_fullscreen()),
    Key([MOD, "shift"], "space", lazy.window.toggle_floating()),
    Key([MOD], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key(
        [MOD, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([MOD], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([MOD], "Return", lazy.spawn("kitty"), desc="Launch terminal"),
    Key([MOD], "b", lazy.spawn("brave-nightly"), desc="Launch Brave browser"),
    Key([MOD], "d", lazy.spawn("emacs"), desc="Launch Emacs"),
    Key([MOD], "e", lazy.spawn("pcmanfm"), desc="Launch Pcmanfm"),
    Key([MOD], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [MOD, "control"],
        "x",
        lazy.spawn("betterlockscreen -l dimblur"),
        desc="Lock Screen",
    ),
    Key([MOD, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([MOD, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Switch focus to specific monitor
    Key([MOD], "a", lazy.to_screen(0), desc="Keyboard focus to monitor 1"),
    Key([MOD], "z", lazy.to_screen(1), desc="Keyboard focus to monitor 2"),
    # Switch focus of monitors
    Key([MOD], "space", lazy.next_screen(), desc="Move focus to next monitor"),
    Key([], "Print", lazy.spawn("flameshot gui -c"), desc="Print screen"),
    Key([MOD], "Print", lazy.spawn("peek"), desc="Record screen"),
    Key([MOD], "c", lazy.spawn(
        "tmpclip -c"), desc="Super copy"),
    Key([MOD], "v", lazy.spawn(
        "tmpclip -p"), desc="Super paste"),
]


if monitor_num() != "1":
    groups = [
        Group(name="egrave", label="", layout="max"),
        Group(name="underscore", label="", layout="bsp"),
        Group(name="ccedilla", label="", layout="bsp"),
        Group(name="agrave", label="", layout="floating"),
        Group(name="F5", label="", layout="max"),
        Group(name="F6", label="", layout="bsp"),
    ]
else:
    groups = [
        Group(name="egrave", label="", layout="max"),
        Group(name="underscore", label="", layout="bsp"),
        Group(name="ccedilla", label="", layout="bsp"),
        Group(name="agrave", label="", layout="floating"),
    ]


def go_to_screen(screen):
    if screen in ["egrave", "underscore", "ccedilla", "agrave"]:
        return 0
    return 1


for i in groups:
    keys.extend(
        [
            # CHANGE WORKSPACES
            Key(
                [MOD],
                i.name,
                lazy.to_screen(go_to_screen(i.name)),
                lazy.group[i.name].toscreen(
                    go_to_screen(i.name), toggle=False),
            ),
            # MOVE WINDOW TO SELECTED WORKSPACE AND FOLLOW MOVED WINDOW TO
            # WORKSPACE
            Key(
                [MOD, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                lazy.to_screen(go_to_screen(i.name)),
                lazy.group[i.name].toscreen(
                    go_to_screen(i.name), toggle=False),
            ),
        ]
    )

# DEFAULT THEME SETTINGS FOR LAYOUTS
layout_theme = {
    "margin": 5,
    "border_width": 0,
    "border_focus": ext_col,
    "border_normal": background,
}

layouts = [
    Max(**layout_theme),
    Bsp(**layout_theme),
    Floating(**layout_theme),
]

widget_defaults = dict(
    font="CaskaydiaCove Nerd Font",
    fontsize=12,
    foreground=ACTIVE,
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
            inactive=INACTIVE,
            active=ACTIVE,
            highlight_method="line",
            this_current_screen_border=ext_col,
            visible_groups=["egrave", "underscore", "ccedilla", "agrave"],
        ),
        widget.GroupBox(
            font="Fira Mono",
            fontsize=25,
            active=ACTIVE,
            inactive=INACTIVE,
            highlight_method="line",
            this_current_screen_border=ext_col,
            visible_groups=["F5", "F6"],
        ),
        widget.TextBox(
            font="Fira Mono",
            text="\uE0Ba",
            padding=-1,
            foreground=ext_col,
            background=background,
            fontsize=35,
        ),
        widget.WindowName(foreground=ACTIVE, background=ext_col),
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
    widgets = init_widgets_list()
    del widgets[2]
    return widgets


def init_widgets_screen2():
    widgets = init_widgets_list()
    # Removing unwanted widgets (systray) on Monitor 2
    del widgets[1]
    del widgets[5:]
    return widgets


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
        [MOD],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [MOD], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([MOD], "Button2", lazy.window.bring_to_front()),
]


floating_layout = Floating(
    border_width=0,
    margin=5,
    border_focus=ext_col,
    border_normal=background,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X
        # client.
        *Floating.default_float_rules,
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


AUTO_FULLSCREEN = True
FOCUS_ON_WINDOW_ACTIVATION = "smart"
DGROUPS_KEY_BINDER = None
dgroups_app_rules = []  # type: List
FOLLOW_MOUSE_FOCUS = True
BRING_FRONT_CLICK = False
CURSOR_WARP = False
AUTO_MINIMIZE = True
WMNAME = "LG3D"
