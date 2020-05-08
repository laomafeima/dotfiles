#!/usr/bin/env python3

# <bitbar.title>Daily Schedule</bitbar.title>

import datetime

schedule = {
    23: {
        0: ["🛏️"]
    },
    21: {
        30: ["👨🏻‍💻✍️", "---", "LeetCode|href=https://leetcode.com"],
        0: ["🏠"]
    },
    19: {
        30: ["👨🏻‍💻✍️", "---", "LeetCode|href=https://leetcode.com"],
        0: ["🍜🚇"]
    },
    16: {
        0: [
            "👨🏻‍💻✍️",
            "---",
            "LeetCode|href=https://leetcode.com",
            "Coding|bash=open -a iTerm|terminal=false"
        ]
    },
    14: {
        0: [
            "🤦🏻",
            "---",
            "Github|href=https://github.com",
            "LeetCode|href=https://leetcode.com"
        ]
    },
    13: {
        0: [
            "👨🏻‍💻📖", 
            "---",
            "Github|href=https://github.com",
            "LeetCode|href=https://leetcode.com"
        ]
    },
    12: {
        0: ["🍜"]
    },
    10: {
        0: ["🤦🏻"]
    },
    9: {
        0: ["🚇"]
    },
    8: {
        0: ["💪"]
    },
}

now = datetime.datetime.now()
for hour, minutes in schedule.items():
    if now.hour >= hour:
        for minute, tasks in minutes.items():
            if now.minute >= minute:
                for task in tasks:
                    print(task)
        break
    else:
        continue
