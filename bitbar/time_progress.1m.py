#!/usr/bin/env python3

# <bitbar.title>Daily Schedule</bitbar.title>

import datetime

DAY_MINUTES = 24 * 60

now = datetime.datetime.now()
day_passed_minute = now.hour * 60 + now.minute
day_progress = round(day_passed_minute / DAY_MINUTES, 2)

week_progress = round((now.weekday() * DAY_MINUTES + day_passed_minute) / (7 * DAY_MINUTES), 2)

year_days = datetime.datetime(now.year + 1, 1, 1) - datetime.datetime(now.year, 1, 1)
year_progress = round((now - datetime.datetime(now.year, 1, 1)) / year_days, 2)

print("{}% {}%".format(int(day_progress * 100), int(week_progress * 100)))
