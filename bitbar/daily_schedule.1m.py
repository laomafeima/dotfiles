#!/usr/bin/env python3

# <bitbar.title>Daily Schedule</bitbar.title>

import datetime

now = datetime.datetime.now()
if now.hour >= 15:
    print("👨🏻‍💻")
