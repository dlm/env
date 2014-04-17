#!/usr/bin/env python

import i3
current = [ws for ws in i3.get_workspaces() if ws['focused']][0]
other = [ws for ws in i3.get_workspaces() if ws['visible'] and not ws['focused']][0]
i3.workspace(other['name'])
