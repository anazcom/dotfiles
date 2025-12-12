export LANG="en_US.UTF-8"
export HISTSIZE=60000
export HISTCONTROL=ignoreboth:erasedups

set -o vi
set -o history

if command -v starship > /dev/null ; then
  eval "$(starship init bash)"
fi

if uname -r | grep -iq wsl ; then
    if command -v proxy > /dev/null ; then
        eval "$(proxy --yes)"
    fi
fi

[[ -f "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"
[[ -f "$HOME/.bash_containers" ]] && source "$HOME/.bash_containers"
[[ -f "$HOME/.bash_env" ]] && source "$HOME/.bash_env"

if command -v tmux-sessionizer > /dev/null ; then
  bind -x '"\C-f": tmux-sessionizer'
fi