#!/usr/bin/env python

import os
import re
from datetime import datetime
import requests

home = os.path.expanduser("~")


def get_time():

    now = datetime.now()
    today_string = now.strftime("%D")
    log_path = f"{home}/.config/qtile/scripts/Time4Salat.log"

    if not os.path.exists(log_path) or not os.path.getsize(log_path):
        make_log(log_path, today_string)

    with open(log_path, "r", encoding="utf8") as log_file:

        log_load = [l.strip() for l in log_file]
        salat_time = log_load[1][1:-
                                 1].replace('"', "").replace("'", "").split(", ")

        if log_load[0] == today_string:
            get_next_salat(now, salat_time)
        else:
            make_log(log_path, today_string)
            get_next_salat(now, salat_time)


def make_log(log_path, today_string):

    with open(log_path, "w", encoding="utf8") as log_file:

        encode = today_string + "\n" + parse()

        log_file.seek(0)
        log_file.truncate()
        log_file.write(encode)


def parse():

    url = "https://mawaqit.net/fr/gm-saint-denis"
    # url = "https://mawaqit.net/fr/m-angouleme"
    # url = "https://mawaqit.net/fr/mosquee-dagen"

    r = requests.get(url)
    regex_data = re.findall(r"times\":\[(.*?)\]", r.text)
    time_string = str(regex_data[0])[1:-1].replace('"', "").split(",")

    return str(time_string)


def get_next_salat(now, time_string):

    time_list = [
        now.replace(hour=int(t[:-3]))
        .replace(minute=int(t[3:]))
        .replace(second=0)
        .replace(microsecond=0)
        for t in time_string
    ]

    for t in time_list:
        delta = str(t - now)
        if str(delta)[0] != "-":
            return print(delta[:4])

    return print(str(time_list[0])[11:-3])


if __name__ == "__main__":
    get_time()
