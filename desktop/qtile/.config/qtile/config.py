import os
import socket
import subprocess
from typing import List  # noqa: F401
from libqtile.lazy import lazy
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
    with open(c, 'r', encoding="UTF-8") as file:
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
    Key([mod], "e", lazy.spawn("emacs"), desc="Launch Emacs"),

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

groups = []

group_names = [
    "y",
    "u",
    "i",
    "o",
    "p",
    "minus",
    "egrave",
    "underscore",
    "ccedilla",
    "agrave"]

group_labels = ["", "", "", "", "", "", "", "", "", ""]

group_layouts = [
    "max",
    "tile",
    "columns",
    "columns",
    "bsp",
    "max",
    "tile",
    "columns",
    "columns",
    "bsp"]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))


def go_to_screen(s):
    if s in "yuiop":
        return 0
    elif s in "'minus''egrave''underscore''ccedilla''agrave'":
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
    font="Cascadia Code",
    fontsize=13,
    foreground=colors[1]
)


def init_widgets_list():
    widgets_list = [
        widget.GroupBox(
            font="FontAwesome",
            fontsize=15,
            inactive=colors[-1],
            active=colors[-2],
            highlight_method="line",
            this_current_screen_border=colors[2],
            visible_groups=['y', "u", "i", "o", "p"]
        ),
        widget.GroupBox(
            font="FontAwesome",
            fontsize=15,
            inactive=colors[-1],
            active=colors[-2],
            highlight_method="line",
            this_current_screen_border=colors[2],
            visible_groups=["minus", "egrave", "underscore", "ccedilla", "agrave"]
        ),
        widget.Prompt(prompt=prompt),
        widget.WindowName(),
        widget.Systray(),
        widget.Sep(linewidth=0, padding=7),
        widget.Clock(foreground=colors[-2], format="[  %a(%d/%m) | ⌚ %H:%M ]"),
    ]

    return widgets_list


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    del widgets_screen1[1]
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    del widgets_screen2[0]
    # Slicing removes unwanted widgets (systray) on Monitor 2
    del widgets_screen2[3:]
    return widgets_screen2


def init_screens():
    return [
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen1(),
                opacity=1.0,
                size=23)),
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen2(),
                opacity=1.0,
                size=23))]


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
        Match(wm_class='megasync')

    ])

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True


@hook.subscribe.startup_once
def start_once():
    subprocess.call(f'{home}/.config/qtile/autostart.sh')


# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True
