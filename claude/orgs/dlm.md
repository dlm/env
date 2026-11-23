# dlm conventions

Applies to every repo under `~/repos/dlm`.

## Work tracking: Linear

Work is tracked in Linear (team **DAV**, via the Linear MCP server), not in
Claude memory or notes in the repo.

- **Every card is in a project.**
  - Finite projects are efforts with an end, like epics. Each description starts
    with `Done when: …`.
  - **Dugnad** is the one forever project: anything no open project's goal
    covers (fixes, upkeep, small improvements, cleanup).
  - A project's goal outranks the repo. Newshound work done in the homelab repo
    belongs to the Newshound project.
- **Out-of-scope ideas** go in the next version's project (e.g. "Newshound
  v2"), created while the current one is running.
- **Creating projects and adding labels are my call.** Suggest them, e.g. when a
  Dugnad card grows big or related cards cluster, but don't create them.
- **Cards** include a `Done when` or acceptance criteria. Long agent-facing
  detail goes in a collapsible "Agent notes" section at the end.
- **Repo labels** (`nixos`, `env`, `homelab`, …) are optional, for filtering
  Dugnad by codebase.
- **Status goes in project updates**, not the project description. The
  description holds what the project is and its `Done when`.
- **Sessions end with `/dlm:end-session`** (or "anything else to capture?"), which
  drafts these updates.

## Commits

Use conventional commits (`feat:`, `fix:`, `chore:`, `docs:`, `refactor:`) in
every dlm repo, including older ones whose history uses a different style.
