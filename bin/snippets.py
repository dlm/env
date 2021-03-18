#!/usr/bin/env python3
from __future__ import print_function

import sys
import subprocess
import datetime

def next_monday():
    now = datetime.datetime.now()
    time_d = datetime.timedelta(7-now.weekday())
    monday = (now + time_d)
    return monday

snippets = {
    "office-hours": (
        "Mon 14:00-14:50 or Fri 12:00-12:50 on webex (https://bit.ly/webex-with-dave)"
    ),
    "webex-url": (
        "https://bit.ly/webex-with-dave"
    ),
    "hangout-url": (
        "https://bit.ly/hangout-with-dave"
    ),
    "calendly-url": (
        "https://calendly.com/dmillman"
    ),
    "date-xdate-(YYYY-mm-dd)": (
        datetime.datetime.now().strftime("%Y-%m-%d")
    ),
    "date-journal(MMMM_dd,_YYYY)": (
        datetime.datetime.now().strftime("%B %0e, %Y")
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
        "Our projects page: https://www.cs.montana.edu/comptag/projects.html\n"
        "\n"
        "Please feel free to take a look and if "
        "something seems of particular interest, let me know and I can "
        "send you more info.\n"
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
    "will-i-be-accepted": (
        "Thank you for following up.  I am not on the admissions committee so "
        "I don't have much insight to answer that question.  But, I can say "
        "that your background does fit well.  And in general, a lot of gaining "
        "admission to any program comes down to your statement of purpose. "
        "The key is to explain what you want to study, how what you want to "
        "study fits into the broader research of the team you want to join, "
        "and how your background makes you uniquely qualified.  One key place "
        "to start is to look at some of the recent papers that the team has "
        "put out. Going through those papers usually demonstrates a high level "
        "of motivation and impresses admissions committees."
    ),
    "letter-of-endorsement": (
        "With respect to the Letter of Endorsement, the wording on the site is "
        "confusing. The letter is NOT required. In general, I only provide a "
        "letter of endorsement for students that have already done research "
        "with me, e.g. MS students applying into the PhD or REU students. I "
        "suggest not worrying about it. Almost none of the packets have a "
        "Letter of Endorsement and it is NOT counted against you if you do not "
        "have one."
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
