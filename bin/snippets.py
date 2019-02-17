#!/usr/bin/env python
from __future__ import print_function

import sys
import subprocess
import datetime

snippets = {
    "office-hours": (
        "Mon 12:30-13:20\n"
        "Thurs 15:00-15:50"
    ),
    "date1_(YYYY-mm-dd)": (
        datetime.datetime.now().strftime("%Y-%m-%d")
    ),
    "date2_(MMMM_dd,_YYYY)": (
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
    "dr-vs-mr": (
        "A helpful tip when interacting with faculty:  When addressing someone "
        "with a PhD in a formal correspondences it is more common to use Dr. X "
        "not Mr. X.  Since most of the faculty at MSU have PhD's, generally, Dr "
        "is usually a good guess. Alternately, if you are not sure how to address "
        "one of your professors, Prof X is almost always a safe option."
    ),
    "emailing-faculty": (
        "A helpful tip when interacting with faculty:  Consider reading "
        "http://bit.ly/emailing-faculty2. It may be helpful in crafting emails "
        "that get your correspondences started on the right foot."
    ),
    "prospective-students": (
        "Thank you for your interest in working with me. "
        "The huge growth in Computational Geometry and Topology recently is "
        "outstanding and I can image your excitement! "
        "Here are a few resources:\n"
        "\n"
        "My website: millman.us\n"
        "My research team's site https://www.cs.montana.edu/comptag/\n"
        "\n"
        "We are currently creating a projects "
        "page: https://www.cs.montana.edu/comptag/projects.html\n"
        "(It is very rough so please feel free to take a look and if "
        "something seems of particular interest, let me know and I can "
        "send you more info).\n"
        "\n"
        "Once you have some ideas about how your interests align with the "
        "group, please don't hesitate to send over a paragraph or two "
        "description and I would be happy hop on a call with you to talk "
        "further.\n"
        "\n"
        "Also, I encourage you to take a look at the CS website for our "
        "admissions procedures: "
        "http://www.cs.montana.edu/future-students-phd.html\n"
    ),
    "gcal-school": (
        "gk17e2542i6vvr21v26ejcj45o@group.calendar.google.com"
    ),
}


def main():
    if len(sys.argv) >= 2:
        value = snippets.get(sys.argv[1], "no entry")
        print(value)
    else:
        for key in snippets.keys():
            print(key)


if __name__ == '__main__':
    main()
