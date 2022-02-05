import os
import socket
import subprocess
from typing import List
from libqtile.command import lazy
from libqtile import bar, layout, widget, hook, extension
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from scripts.my_widgets import kekram, keklayout, kekdate, kektime, time4salat


mod = "mod4"
mod1 = "alt"
mod2 = "control"
terminal = "kitty"
home = os.path.expanduser("~")
prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

background = "#161320"
ext_col = "#5F4D66"
int_col = "#937986"
active = "#FBF5F3"
inactive = "#6E6C7E"

keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod],
        "r",
        lazy.run_extension(
            extension.DmenuRun(
                dmenu_command="dmenu_run",
                dmenu_prompt=">",
                dmenu_font="FontAwesome",
                foreground=inactive,
                background=background,
                selected_background=ext_col,
                selected_foreground=active,
                dmenu_height=23,
            )
        ),
    ),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),
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
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
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
    # Sound
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        "amixer -c 1 sset Master 1- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        "amixer -c 1 sset Master 1+ unmute")),
    # Switch focus to specific monitor
    Key([mod], "a", lazy.to_screen(0), desc="Keyboard focus to monitor 1"),
    Key([mod], "z", lazy.to_screen(1), desc="Keyboard focus to monitor 2"),
    # Switch focus of monitors
    Key([mod], "space", lazy.next_screen(), desc="Move focus to next monitor"),
]

groups = [
    Group("y", label="", layout="max"),
    Group("u", label="", layout="columns"),
    Group("i", label="", layout="columns"),
    Group("o", label="", layout="tile"),
    Group("p", label="", layout="max"),
    Group("minus", label="", layout="max"),
    Group("egrave", label="", layout="columns"),
    Group("underscore", label="", layout="columns"),
    Group("ccedilla", label="", layout="tile"),
    Group("agrave", label="", layout="bsp"),
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
                lazy.group[i.name].toscreen(
                    go_to_screen(i.name), toggle=False),
            ),
            # MOVE WINDOW TO SELECTED WORKSPACE AND FOLLOW MOVED WINDOW TO
            # WORKSPACE
            Key(
                [mod, "shift"],
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
    "margin": 7,
    "border_width": 2,
    "border_focus": ext_col,
    "border_normal": background,
}

layouts = [
    layout.Max(**layout_theme),
    layout.Columns(**layout_theme),
    layout.Stack(num_stacks=3, margin=190, border_width=2),
    layout.Bsp(**layout_theme),
    layout.Tile(shift_windows=True, **layout_theme),
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
            font="FontAwesome",
            text="\ue0ba",
            padding=-3,
            foreground=background,
            background=ext_col,
            fontsize=35,
        ),
        widget.GroupBox(
            font="FontAwesome",
            fontsize=15,
            inactive=inactive,
            active=active,
            highlight_method="line",
            this_current_screen_border=ext_col,
            other_screen_border=inactive,
            other_current_screen_border=active,
            visible_groups=["y", "u", "i", "o", "p"],
        ),
        widget.GroupBox(
            font="FontAwesome",
            fontsize=15,
            active=active,
            inactive=inactive,
            highlight_method="line",
            this_current_screen_border=ext_col,
            other_screen_border=inactive,
            other_current_screen_border=active,
            visible_groups=["minus", "egrave",
                            "underscore", "ccedilla", "agrave"],
        ),
        widget.TextBox(
            font="FontAwesome",
            text="\uE0Ba",
            padding=0,
            foreground=ext_col,
            background=background,
            fontsize=35,
        ),
        widget.WindowName(foreground=active, background=ext_col),
        widget.TextBox(
            font="FontAwesome",
            text="\uE0Ba",
            padding=0,
            foreground=background,
            background=ext_col,
            fontsize=35,
        ),
        widget.GenPollText(
            update_interval=1,
            padding=5,
            background=background,
            mouse_callbacks={"Button1": lazy.spawn("kitty -e btop")},
            func=kekram,
        ),
        widget.Net(format="↓ {down} ↑ {up}", background=background),
        widget.TextBox(
            font="FontAwesome",
            text="\ue0ba",
            padding=0,
            foreground=int_col,
            background=background,
            fontsize=35,
        ),
        widget.GenPollText(
            update_interval=60, padding=5, background=int_col, func=time4salat
        ),
        widget.TextBox(
            font="FontAwesome",
            text="\uE0Ba",
            padding=0,
            foreground=ext_col,
            background=int_col,
            fontsize=35,
        ),
        widget.GenPollText(
            update_interval=1,
            padding=0,
            background=ext_col,
            mouse_callbacks={"Button1": lazy.spawn("kitty -e cal")},
            func=kekdate,
        ),
        widget.TextBox(
            font="FontAwesome",
            text="\uE0Ba",
            padding=0,
            foreground=int_col,
            background=ext_col,
            fontsize=35,
        ),
        widget.GenPollText(
            update_interval=1, background=int_col, padding=0, func=kektime
        ),
        widget.TextBox(
            font="FontAwesome",
            text="\ue0ba",
            padding=0,
            foreground=background,
            background=int_col,
            fontsize=35,
        ),
        widget.GenPollText(
            fontsize=15,
            update_interval=0.2,
            padding=1,
            background=background,
            mouse_callbacks={"Button1": lazy.spawn("key")},
            func=keklayout,
        ),
        widget.Systray(),
        widget.TextBox(
            font="FontAwesome",
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

    return [
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen1(),
                background=background,
                opacity=1.0,
                size=23,
            )
        ),
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen2(),
                background=background,
                opacity=1.0,
                size=23,
            )
        ),
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
    border_focus=active,
    border_normal=inactive,
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
