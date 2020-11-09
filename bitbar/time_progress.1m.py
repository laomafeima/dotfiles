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

days_left = datetime.datetime(now.year + 1, 1, 1)  - now
print("{} days".format(days_left.days))
# 番茄计数
print("---")
deadline = [
        {"hour": 10, "minute": 00},
        {"hour": 10, "minute": 40},
        {"hour": 11, "minute": 20},
        {"hour": 12, "minute": 00},
        {"hour": 14, "minute": 00},
        {"hour": 14, "minute": 40},
        {"hour": 15, "minute": 20},
        {"hour": 16, "minute": 00},
        {"hour": 16, "minute": 40},
        {"hour": 17, "minute": 20},
        ]

tomatos = ""
for i in deadline:
    if now.hour * 60 + now.minute >= i["hour"] * 60 + i["minute"]:
        if len(tomatos) >= 4:
            tomatos += "🍅"
        else:
            tomatos += "🍏"

print(tomatos + " " + str(len(tomatos)))
