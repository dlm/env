---
name: eod
description: Draft Dave's end-of-day summary of work and workouts as a pasteable markdown list. Use when the user types /dlm:eod or asks for a summary of what they did on a given day.
---

# End-of-day summary

Draft a short summary of one day for the user to paste into their own log.
The argument is the day: empty means today, otherwise a date or a phrase like
"yesterday" or "fri". Resolve it to a YYYY-MM-DD in local time.

## Gather

Run both at once:

1. `${CLAUDE_PLUGIN_ROOT}/skills/eod/collect.sh YYYY-MM-DD`. It prints git commits, the
   user's messages from Claude Code sessions (in local time) and the Linear
   changes made from those sessions. Ignore the session running this skill.
2. Strava `list_activities` with `range_start` `YYYY-MM-DDT00:00:00`,
   `range_end` `YYYY-MM-DDT23:59:59` and `use_preferred_units: true`. Load
   the tool with ToolSearch first if it is deferred.

If a session's messages don't make clear what was done, read more of that
transcript rather than guessing.

## Write

Match this format and tone exactly:

```
### November 20, 2026
- homelab: setup flux
- blqsort: port generators from python to go
- blqsort: benchmarks on intel and mac
- blqsort: writeup started
- ssh: fixed bug sshing from laptop to mac
- gym: tmp with DJDK
```

- Write one line per accomplishment, lowercase and terse.
- Start every line with a `project:` prefix, even when it is the only line
  for that project. "writeup started" says little on its own;
  "blqsort: writeup started" says what was written. Pick the prefix in this
  order:
  1. The repo name, or for a scratch directory like `~/tmp/go`, the name of
     what is being built there (`blqsort`).
  2. For work with no repo, the Linear project the work's card belongs to.
  3. Otherwise the tool or system it touched (`ssh:`, `linear:`, `claude:`).
  Prefer long-running names over short-lived Linear projects, so the same
  work keeps the same prefix across days and weeks.
- Describe outcomes, not process. Merge related commits into one line, and
  leave out commit hashes, times and chores like formatting or lint fixes.
- Include a Linear issue ID only when an issue was completed.
- Put workouts last, prefixed with the kind of workout (`mtb:`, `zwift:`,
  `walk:`, `gym:`). Use the activity's own name when it says what it was
  (e.g. "TMP DJDK" → "gym: tmp with DJDK"). Add distance and climbing for
  rides.
- Leave out quick how-to questions unless they fixed a real problem.

Print the entry in a single code block so it is easy to copy. Below it, in
one or two lines, mention anything you were unsure about and remind the user
to add what leaves no trace, such as meetings or time away from the computer.
If no source has anything for the day, say so instead of inventing lines.
