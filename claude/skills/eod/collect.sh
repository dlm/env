#!/usr/bin/env bash
# Gather local evidence of work done on one day: git commits and Claude Code sessions.
# Usage: collect.sh [YYYY-MM-DD]   (defaults to today, local time)
set -euo pipefail

day="${1:-$(date +%F)}"
next=$(date -d "$day + 1 day" +%F)
# Claude transcripts are stamped in UTC, so convert the local-day window.
start_utc=$(date -u -d "@$(date -d "$day 00:00" +%s)" +%Y-%m-%dT%H:%M)
end_utc=$(date -u -d "@$(date -d "$next 00:00" +%s)" +%Y-%m-%dT%H:%M)
me=$(git config --global user.name)

echo "# $day ($(date -d "$day" +%A))"

echo
echo "## Git commits"
find ~ -maxdepth 5 -name .git -type d 2>/dev/null | while read -r d; do
  r=$(dirname "$d")
  out=$(git -C "$r" log --all --author="$me" --since="$day 00:00" --until="$next 00:00" \
    --format='%ad %h %s' --date=format-local:%H:%M 2>/dev/null | awk 'NF > 2' || true)
  if [ -n "$out" ]; then printf '### %s\n%s\n' "${r/#$HOME/~}" "$out"; fi
done

echo
echo "## Claude Code sessions (user messages, local time)"
unclosed=""
for f in ~/.claude/projects/*/*.jsonl; do
  out=$(jq -r --arg s "$start_utc" --arg e "$end_utc" '
    select(.type == "user" and (.timestamp // "") >= $s and (.timestamp // "") < $e)
    | (.timestamp | sub("\\.[0-9]+Z$"; "Z") | fromdate | strflocaltime("%H:%M")) + " "
      + (if (.message.content | type) == "string" then .message.content
         else ([.message.content[]? | select(.type == "text") | .text] | join(" ")) end)
    # a loaded skill shows up as a user message, but its text is not work done
    | select(test("^[0-9:]{5} Base directory for this skill:") | not)
  ' "$f" 2>/dev/null \
    | grep -vE '^[0-9:]{5} *$|<(task-notification|system-reminder|output-file|tool-use-id|command-)' \
    | sed -E 's/<pasted_content[^>]*>.*//' | cut -c1-200 || true)
  [ -z "$out" ] && continue
  name=$(basename "$(dirname "$f")")
  printf '### %s\n%s\n' "$name" "$out"
  # a session is closed off once /dlm:end-session has run in it that day
  closed=$(jq -r --arg s "$start_utc" --arg e "$end_utc" '
    select(.type == "user" and (.timestamp // "") >= $s and (.timestamp // "") < $e)
    | (if (.message.content | type) == "string" then .message.content
       else ([.message.content[]? | select(.type == "text") | .text] | join(" ")) end)
    | select(test("^Base directory for this skill: [^ ]*/end-session"))
    | 1
  ' "$f" 2>/dev/null | head -1 || true)
  if [ -z "$closed" ]; then
    last=$(grep -oE '^[0-9]{2}:[0-9]{2}' <<<"$out" | tail -1)
    unclosed+="$name (last message $last)"$'\n'
  fi
done

echo
echo "## Sessions not closed with /dlm:end-session"
printf '%s' "${unclosed:-none}"
echo

echo
echo "## Linear changes made from Claude sessions"
jq -r --arg s "$start_utc" --arg e "$end_utc" '
  select(.type == "assistant" and (.timestamp // "") >= $s and (.timestamp // "") < $e)
  | .message.content[]? | select(.type == "tool_use" and (.name | test("linear__save_(issue|comment)")))
  | (.input.id // .input.issueId // "new issue") + " " + ((.input.state // .input.title // "") | tostring)
' ~/.claude/projects/*/*.jsonl 2>/dev/null | sort -u
