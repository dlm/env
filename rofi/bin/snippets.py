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
    "date (MMMM dd, YYYY)": (
        datetime.datetime.now().strftime("%B %e, %Y")
    ),
    "discussion-board-code-help": (
        "I am happy to help.  You are welcome to come by office hours any time "
        "or post on the discussion board.  (I prefer the board over direct "
        "email because it may help a few others out that are having the same "
        "problem).  If you go the route of posting, please add a few "
        "additional pieces of information such as the error message that you "
        "are getting, where you are getting the error, your OS, your "
        "development environment and, if you can find it, the graphics driver "
        "and graphics card information."
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
