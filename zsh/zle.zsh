# Additional bindings

### FZF awesomeness
# fo [FUZZY PATTERN] - Open the selected file with the default editor
#   - Exit if there's no match (--exit-0)
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  out=$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

function _fzf-fo-widget() {
    zle kill-whole-line
    BUFFER="fo"
    zle accept-line
}
zle -N _fzf-fo-widget
bindkey '\eo' _fzf-fo-widget

