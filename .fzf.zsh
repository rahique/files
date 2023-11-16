source /usr/share/doc/fzf/examples/key-bindings.zsh
# Use Nerd Font icons with fzf
export FZF_DEFAULT_OPTS="--ansi --prompt='❯ ' --pointer='❯ ' --color='bg+:#1C1C1C,bg:#1C1C1C,spinner:#af2a2c,hl:#af2a2c,prompt:#af2a2c',pointer:#ededed"
export FZF_DEFAULT_COMMAND="find"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#cusotm
# Function to show command suggestions from history using fzf
history_suggestions() {
  local selected_command
  selected_command=$(history | cut -c 8- | sort -u | awk '{print "❇  " $0}' | fzf --height=50% --reverse --prompt="❯ " --query="$LBUFFER" | sed 's/^❇  //')
  if [ -n "$selected_command" ]; then
    LBUFFER="$selected_command"
    zle reset-prompt
  fi
  zle reset-prompt
}
zle -N history_suggestions
bindkey '^h' history_suggestions

find_select() {
    local result
    result=$(find . -type f | fzf --height=50% --reverse --preview 'batcat --color=always --style=plain,grid --line-range :500 {}' --expect=enter)
    if [ -n "$result" ]; then
        local selected_path
        selected_path=$(echo "$result" | sed -n '2p')
        if [ -f "$selected_path" ]; then
            # Extract directory part if a file is selected
            selected_path=$(dirname "$selected_path")
        fi
        zle reset-prompt
        LBUFFER="$LBUFFER$selected_path"
    fi
    zle reset-prompt
}
zle -N find_select
bindkey '^@' find_select
