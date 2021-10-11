#!/usr/bin/env python

import re
import requests
from datetime import datetime

def parse():

    url="https://mawaqit.net/fr/gm-saint-denis"
    # agen="https://mawaqit.net/fr/mosquee-dagen"

    r = requests.get(url)
    j = re.findall(r'times":(.*),"womenSpace', r.text)
    s_l = str(j[0])[1:-1].replace('"','').split(',')

    now = datetime.now()
    # fnow = now.strftime('%H:%M')

    kek = [now.replace(hour=int(t[:-3])).replace(minute=int(t[3:])).replace(second=0).replace(microsecond=0) for t in s_l]

    if kek[-1] >= now:
        for t in kek:
            # ft = t.strftime('%H:%M')
            delta = str(t - now)
            if str(delta)[0] != "-":
                print(delta[:4])
                break

    print(str(kek[0])[11:-3])

if __name__ == "__main__":
    parse()

