---
name: eod
description: Draft Dave's end-of-day summary of work and workouts as a pasteable markdown list. Use when the user types /dlm:eod or asks for a summary of what they did on a given day.
---

# End-of-day summary

Draft a short summary of one day for the user to paste into their own log.
The argument is the day: empty means today, otherwise a date or a phrase like
"yesterday" or "fri". Resolve it to a YYYY-MM-DD in local time.

## Gather

Run steps 1 and 3 at once, then step 2, which needs the window from step 1.

1. `${CLAUDE_PLUGIN_ROOT}/skills/eod/collect.sh YYYY-MM-DD`. It prints the
   day's UTC window, git commits, the user's messages from Claude Code
   sessions (in local time), the sessions that were never closed with
   `/dlm:end-session`, and Linear edits and comments made from sessions.
2. Linear `list_issues` with `updatedAt` set to the start of the UTC window,
   `limit: 250` and `fields` `title`, `status`, `project`, `createdAt`,
   `startedAt`, `completedAt` and `canceledAt`. Follow `cursor` while
   `hasNextPage` is true. Linear can only filter on "updated after", so keep
   only the issues whose `createdAt`, `startedAt`, `completedAt` or
   `canceledAt` falls inside the window; the rest changed on a later day.
   Treat this as the source of truth for card status. The last section of
   step 1 adds the edits and comments made through Claude, which say what
   happened on a card; edits and comments made in the Linear app are not
   covered.
3. Strava `list_activities` with `range_start` `YYYY-MM-DDT00:00:00`,
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

- Write one line per accomplishment, lowercase and terse. Keep every line,
  including the `- ` and prefix, to 80 characters or fewer. Shorten the
  wording or split it into two lines rather than wrapping.
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
- Include a Linear issue ID only when an issue was completed. Write a
  completed issue as an outcome under the repo it was done in, not as a
  separate `linear:` line. Summarize cards that were only filed or canceled
  in one line per project (e.g. "dugnad: filed 4 maintenance cards") rather
  than listing each.
- Put workouts last, prefixed with the kind of workout (`mtb:`, `zwift:`,
  `walk:`, `gym:`). Use the activity's own name when it says what it was
  (e.g. "TMP DJDK" → "gym: tmp with DJDK"). Add distance and climbing for
  rides.
- Leave out quick how-to questions unless they fixed a real problem.

Print the entry in a single code block so it is easy to copy. Below it, in
one or two lines, mention anything you were unsure about and remind the user
to add what leaves no trace, such as meetings or time away from the computer.

Then list the sessions that were not closed with `/dlm:end-session`, one per
line with the project and the time of its last message, and suggest closing
them before calling it a day. Skip quick one-off questions, such as a single
how-to message, since there is nothing in them to capture. Leave this out
when every session was closed.
If no source has anything for the day, say so instead of inventing lines.
