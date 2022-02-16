#!/usr/bin/env python

import os, psutil, subprocess


def kekram():
    cpu = "CPU: " + str(psutil.cpu_percent(percpu=False)) + "%"
    mem = " / MEM: " + str(psutil.virtual_memory().percent) + "% /"
    return cpu + mem


def kekdate():
    return (
        "📆 "
        + subprocess.check_output(
            os.path.expanduser("~/.config/qtile/scripts/kekdate.sh")
        )
        .decode("utf8")
        .strip()
    )


def kektime():
    return (
        "🕒 "
        + subprocess.check_output(
            os.path.expanduser("~/.config/qtile/scripts/kektime.sh")
        )
        .decode("utf8")
        .strip()
    )


def time4salat():
    return (
        "🕋 "
        + subprocess.check_output(
            os.path.expanduser("~/.config/qtile/scripts/Time4Salat.py")
        )
        .decode("utf8")
        .strip()
    )


def monitor_num():
    return (
        subprocess.check_output(
            os.path.expanduser("~/.config/qtile/scripts/monitors.sh")
        )
        .decode("utf8")
        .strip()
    )
