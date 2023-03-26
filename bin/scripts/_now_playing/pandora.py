#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import deque
import os
import re
from subprocess import check_output, CalledProcessError

PIANOBAR_OUT = '~/.config/pianobar/out'
DELIM = '\x1b[2K|>'
SONG_SPLIT = '\x1b[0m on '


def is_running():
    running = False
    try:
        check_output('ps -u $(id -u) -o comm | grep -q "^pianobar$"',
                     shell=True)
        running = True
    except CalledProcessError:
        running = False
    return running


def tail(filename, n=20):
    return deque(open(filename), n)


def find_current_line(lines):
    name = DELIM + ' could not find delimiter'
    for line in reversed(lines):
        if DELIM in line:
            name = line
            break
    return name


def clean_string(x):
    return re.sub(r'\x1b[^m]*m', '', x).strip()


def extract_name_from_line(line):
    title_data = line.split(SONG_SPLIT)[0].strip()
    title = title_data.replace(DELIM, '').strip()

    components = title.split('by [34m')
    artist = clean_string(components[0])
    song = clean_string(components[1])
    return artist + "|" + song


def get_current_song_name():
    filename = os.path.expanduser(PIANOBAR_OUT)
    lines = tail(filename)
    name_line = find_current_line(lines)
    name = extract_name_from_line(name_line)
    return name

if __name__ == "__main__":
    running = is_running()
    print (get_current_song_name() if running else "")
