import os
import socket
import subprocess
import psutil
from typing import List
from libqtile.lazy import lazy
from libqtile import bar, layout, widget, hook, extension
from libqtile.config import Click, Drag, Group, Key, Match, Screen

mod = "mod4"
mod1 = "alt"
mod2 = "control"
terminal = "kitty"
home = os.path.expanduser('~')
prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

colors = {
        "background":"#18181B",
        "active":"#FBF5F3",
        "inactive":"#6E6C7E",
        "taupe":"#92828D",
        "purple":"#502F4C",
        "sienna":"#360A14",
        "claret":"#820933",
        "rosewood":"#52050A",
        "blue":"#222E50",
        "lavender":"#E5E1EE",
        "trueblue":"#4464AD",
        "richblack":"#0D1821",
        "greyweb":"#808080"
        }

keys = [

        Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
        Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
        Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
        Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

        Key([mod], 'r', lazy.run_extension(extension.DmenuRun(
            dmenu_command="dmenu_run",
            dmenu_prompt=">",
            dmenu_font="Cascadia Code",
            foreground=colors["inactive"],
            background=colors["background"],
            selected_background=colors["sienna"],
            selected_foreground=colors["active"],
            dmenu_height=23,
        ))),
        # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

        Key([mod], "space", lazy.layout.next(),
            desc="Move window focus to other window"),

        Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
            desc="Move window to the left"),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
            desc="Move window to the right"),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

        Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
        Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
        Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
        Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

        Key([mod], "f", lazy.window.toggle_fullscreen()),
        Key([mod, "shift"], "space", lazy.window.toggle_floating()),

        Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
        Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack"),
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
        Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 1 sset Master 1- unmute")),
        Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 1 sset Master 1+ unmute")),

        # Switch focus to specific monitor
        Key([mod], "a",
            lazy.to_screen(0),
            desc='Keyboard focus to monitor 1'
            ),
        Key([mod], "z",
                lazy.to_screen(1),
                desc='Keyboard focus to monitor 2'
                ),
    # Switch focus of monitors
    Key([mod], "comma",
            lazy.next_screen(),
            desc='Move focus to next monitor'
            ),
]

groups = [
        Group("y", label="", layout="max"),
        Group("u", label="", layout="stack"),
        Group("i", label="", layout="columns"),
        Group("o", label="", layout="tile"),
        Group("p", label="", layout="max"),
        Group("minus", label="", layout="max"),
        Group("egrave", label="", layout="stack"),
        Group("underscore", label="", layout="columns"),
        Group("ccedilla", label="", layout="tile"),
        Group("agrave", label="", layout="bsp"),
        ]

def go_to_screen(s):
    if s in "yuiop":
        return 0
    return 1

for i in groups:
    keys.extend([

        # CHANGE WORKSPACES
        Key([mod], i.name, lazy.to_screen(go_to_screen(i.name)),
            lazy.group[i.name].toscreen(go_to_screen(i.name), toggle=False)),

        # MOVE WINDOW TO SELECTED WORKSPACE AND FOLLOW MOVED WINDOW TO
        # WORKSPACE
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name), lazy.to_screen(go_to_screen(
            i.name)), lazy.group[i.name].toscreen(go_to_screen(i.name), toggle=False)),
        ])

# DEFAULT THEME SETTINGS FOR LAYOUTS
layout_theme = {
        "margin": 7,
        "border_width": 2,
        "border_focus": colors["greyweb"],
        "border_normal": colors["inactive"]
        }

layouts = [
        layout.Max(**layout_theme),
        layout.Columns(**layout_theme),
        layout.Stack(num_stacks=1, margin=190, border_focus=colors["greyweb"], border_width=2),
        layout.Bsp(**layout_theme),
        layout.Tile(shift_windows=True, **layout_theme),
        ]

widget_defaults = dict(
        font="Cascadia Code",
        fontsize=12,
        foreground=colors["active"]
        )

def kekram():
    return "(Mem: " + str(psutil.virtual_memory().percent) + "%)"

def keklayout():
    return "(" + subprocess.check_output(os.path.expanduser("~/.config/qtile/scripts/keklayout.sh")).decode('utf8').strip() + ")"

def kekdate():
    return "📆 " + subprocess.check_output(os.path.expanduser("~/.config/qtile/scripts/kekdate.sh")).decode('utf8').strip()

def kektime():
    return "🕒 " + subprocess.check_output(os.path.expanduser("~/.config/qtile/scripts/kektime.sh")).decode('utf8').strip()

def time4salat():
    return "🕋 " + subprocess.check_output(os.path.expanduser("~/.config/qtile/scripts/Time4Salat.py")).decode('utf8').strip()

def monitor_num():
    return subprocess.check_output(os.path.expanduser("~/.config/qtile/scripts/monitors.sh")).decode('utf8').strip()

def init_widgets_list():
    return [
            widget.TextBox(text = "\ue0be", padding=-3, foreground=colors["background"], background=colors["sienna"], fontsize=35),
            widget.GroupBox(
                font="FontAwesome",
                fontsize=15,
                inactive=colors["inactive"],
                active=colors["active"],
                highlight_method="line",
                this_current_screen_border=colors["purple"],
                other_screen_border=colors["inactive"],
                other_current_screen_border=colors["active"],
                visible_groups=['y', "u", "i", "o", "p"]
                ),
            widget.GroupBox(
                font="FontAwesome",
                fontsize=15,
                inactive=colors["inactive"],
                active=colors["active"],
                highlight_method="line",
                this_current_screen_border=colors["purple"],
                other_screen_border=colors["inactive"],
                other_current_screen_border=colors["active"],
                visible_groups=["minus", "egrave", "underscore", "ccedilla", "agrave"]
                ),
            widget.Prompt(prompt=prompt, background=colors["background"]),
            widget.TextBox(text = "\uE0Be", padding=0, foreground=colors["sienna"], background=colors["background"], fontsize=35),
            widget.WindowName(foreground=colors["active"], background=colors["sienna"]),
            widget.TextBox(text = "\uE0Be", padding=0, foreground=colors["background"], background=colors["sienna"], fontsize=35),
            widget.Spacer(length=599),
            widget.GenPollText(update_interval=60, padding=5, background=colors["background"], mouse_callbacks={'Button1': lazy.spawn('kitty -e btop')}, func=kekram),
            widget.TextBox(text = "\ue0be", padding=0, foreground=colors["purple"], background=colors["background"], fontsize=35),
            widget.GenPollText(update_interval=60, padding=5, background=colors["purple"], func=time4salat),
            widget.TextBox(text = "\uE0Be", padding=0, foreground=colors["sienna"], background=colors["purple"], fontsize=35),
            widget.Volume(padding=5, emoji=True, foreground=colors["purple"], background=colors["sienna"], fontsize=13),
            widget.Volume(padding=0, background=colors["sienna"]),
            widget.TextBox(text = "\uE0Be", padding=0, foreground=colors["purple"], background=colors["sienna"], fontsize=35),
            widget.GenPollText(update_interval=1, padding=0, background=colors["purple"], mouse_callbacks={'Button1': lazy.spawn("kitty -e cal")}, func=kekdate),
            widget.TextBox(text = "\uE0Be", padding=0, foreground=colors["sienna"], background=colors["purple"], fontsize=35),
            widget.GenPollText(update_interval=1, background=colors["sienna"], padding=0, func=kektime),
            widget.TextBox(text = "\ue0be", padding=0, foreground=colors["background"], background=colors["sienna"], fontsize=35),
            widget.GenPollText(update_interval=0.2, padding=0, background=colors["background"], mouse_callbacks={'Button1': lazy.spawn("key")}, func=keklayout),
            # widget.TextBox(text = "\uE0Be", padding=0, foreground=colors["background"], background=colors["purple"], fontsize=23),
            widget.Systray(),
            widget.TextBox(text = "\ue0be", padding=-3, foreground=colors["sienna"], background=colors["background"], fontsize=35)
            ]


def init_widgets_screen1():
    w = init_widgets_list()
    del w[2]
    return w


def init_widgets_screen2():
    w = init_widgets_list()
    del w[1]
    # Slicing removes unwanted widgets (systray) on Monitor 2
    del w[7:-1]
    return w


# def init_screens():

screens = [
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen1(),
                background=colors["background"],
                opacity=1.0,
                size=23)),
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen2(),
                background=colors["background"],
                opacity=1.0,
                size=23))
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
            lazy.window.bring_to_front())
        ]

floating_layout = layout.Floating(
        border_width=3,
        margin=5,
        border_focus=colors["active"],
        border_normal=colors["inactive"],
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

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
reconfigure_screens = True
focus_on_window_activation = "smart"
auto_minimize = True
wmname = "LG3D"


@hook.subscribe.startup_once
def start_once():
    subprocess.call(f'{home}/.config/qtile/scripts/autostart.sh')
