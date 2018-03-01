#!/usr/bin/env python
from __future__ import print_function

import sys
import subprocess
import datetime

snippets = {
    "office-hours": (
        "Mon 17:00-18:00\n"
        "Thurs 12:00-13:00"
    ),
    "date (YYYY-mm-dd)": (
        datetime.datetime.now().strftime("%Y-%m-%d")
    ),
}


def main():
    if len(sys.argv) >= 2:
        key = snippets.get(sys.argv[1], "no entry")
        subprocess.call("echo '%s' | xclip -selection c >/dev/null" % key, shell=True)
    else:
        for key in snippets.keys():
            print(key)


if __name__ == '__main__':
    main()
