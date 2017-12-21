# -*- coding: utf-8 -*-

"""Evaluate simple python expressions.
Use it with care every keystroke triggers an evaluation."""

from albertv0 import *
from builtins import pow

import datetime

__iid__ = "PythonInterface/v0.1"
__prettyname__ = "XEvernote"
__version__ = "1.0"
__trigger__ = "xevernote"
__author__ = "David Millman"
__dependencies__ = []

def handleQuery(query):
    if query.isTriggered:
        item = Item(id=__prettyname__, completion=query.rawString)
        stripped = query.string.strip()
        try:
            result = datetime.datetime.today().strftime('%B %d, %Y')
        except Exception as ex:
            result = ex
        item.text = str(result)
        item.subtext = type(result).__name__
        item.addAction(ClipAction("Copy result to clipboard", str(result)))
        item.addAction(FuncAction("Execute", lambda: exec(str(result))))
        return item
