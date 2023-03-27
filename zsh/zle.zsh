# Additional bindings

### FZF awesomeness
# fzf-open [FUZZY PATTERN] - Open the selected file with the default editor
#   - Exit if there's no match (--exit-0)
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
function fzf-open() {
  local out file key
  out=$(fzf-tmux -p --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

function _fzf-open-widget() {
    zle kill-whole-line
    BUFFER="fzf-open"
    zle accept-line
}
zle -N _fzf-open-widget
# bindkey '\eo' _fzf-fo-widget
bindkey '^o' _fzf-open-widget

## History awesomeness
# cursor and the ctrl+N and ctrl+P moves through local history
# ctrl+cursro moves through global history
# ctrl+R will still search over global history
function _up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}
zle -N _up-line-or-local-history

function _down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}
zle -N _down-line-or-local-history

# map local up
up_key=${terminfo[kcuu1]}
bindkey "${up_key}" _up-line-or-local-history       # cursor up
bindkey "^P" _up-line-or-local-history              # ctrl+p

# map local down
down_key=${terminfo[kcud1]}
bindkey "${down_key}" _down-line-or-local-history   # cursor down
bindkey "^N" _down-line-or-local-history            # ctrl+n

# map global
bindkey "^[[1;5A" up-line-or-history                # ctrl+Cursor up
bindkey "^[[1;5B" down-line-or-history              # ctrl+Cursor down

