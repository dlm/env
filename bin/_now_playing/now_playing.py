#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
from subprocess import Popen, PIPE


def run_src(cmd):
    p = Popen(cmd, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    output, err = p.communicate()
    return output.strip()


def trim(src, max_len):
    return src[:max_len-1] + '…' if len(src) > max_len else src


def format_song(data):
    data = data.split('|')
    result = ''
    if len(data) > 1:
        artist = data[0]
        song = data[1]
        result = trim(artist, 10) + ' ♪ ' + trim(song, 8)
    return result


def song_src(src):
    output = run_src(src)
    return format_song(output)


path_root = os.path.dirname(os.path.abspath(__file__))
sources = ('pandora.py', 'spotify.scpt')
output = 'No ♪'
for source in sources:
    path = os.path.join(path_root, source)
    result = song_src(path)
    if len(result) > len(output):
        output = result

print(output)
