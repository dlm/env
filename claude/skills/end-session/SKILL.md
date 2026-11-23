---
name: end-session
description: Wrap up a work session so nothing is left only in the conversation. Use when the user types /dlm:end-session or asks "anything else to capture?" (or similar) near the end of a session.
---

# End session

Make sure what this session decided and did lives somewhere durable. Report
gaps, and fix them only once the user says yes.

## 1. Tracker

Check the org's `CLAUDE.md` for where work is tracked (for dlm: Linear).

- Every decision made this session is on a card, a card comment or a project
  description, not only in the chat.
- Card states match reality: started work is In Progress, finished work is
  Done, and blocked work isn't sitting in Todo.
- New follow-ups have cards, in the project the org's rules put them in.

## 2. Repos

For each repo the session touched, look at uncommitted changes and at commits
that haven't been pushed. Repos differ: a `.jj` directory means jj (colocated
with git), otherwise plain git.

- **jj**: `jj st` for changes in `@`, `jj log -r 'remote_bookmarks().. ~ empty()'` for
  unpushed commits (a bookmark shown as `main*` is ahead of its remote).
- **git**: `git status --short` for changes, `git log @{u}..` for unpushed
  commits.

List what's left and offer to commit or push it, using that repo's tool. Never
push unless the user says so.

Check the workspace or worktree list first: the user sometimes has another
session open in the same repo, and its changes aren't yours to commit.

## 3. Instructions and memory

- Did the session settle a durable decision or convention that belongs in a
  repo or org `CLAUDE.md`? Propose the edit.
- Are any memory notes now stale, duplicated by a `CLAUDE.md`, or tracker
  content that belongs in the tracker? Propose removing them.

## 4. Status update

For each project the session moved forward, draft a project update: health,
what's done, what's next, and open questions. Keep it short and use card IDs.
Show the drafts and post only after the user approves.

## 5. Report

One short list: what was already captured, what you changed, and anything you
left for the user to decide.
