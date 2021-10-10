#!/usr/bin/env python

import re
import requests
from datetime import datetime

def parse():

    url="https://mawaqit.net/fr/gm-saint-denis"
    agen="https://mawaqit.net/fr/mosquee-dagen"

    r = requests.get(url)
    j = re.findall(r'times":(.*),"womenSpace', r.text)
    s_l = str(j[0])[1:-1].replace('"','').split(',')

    now = datetime.now()
    fnow = now.strftime('%H:%M')

    for t in s_l:
        t = now.replace(hour=int(t[:-3])).replace(minute=int(t[3:])).replace(second=0).replace(microsecond=0)
        ft = t.strftime('%H:%M')
        # print(fnow , ft)
        delta = str(t - now)
        # print(delta)
        if str(delta)[0] != "-":
            # print(ft, delta[:4])
            print(delta[:4])
            break

if __name__ == "__main__":
    parse()

