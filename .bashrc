export LANG="en_US.UTF-8"
export HISTSIZE=60000
export HISTCONTROL=ignoreboth:erasedups

set -o vi
set -o history

alias ls='ls -a --color=auto'
alias grep='grep --color=auto'
alias dotfiles='cd ~/dotfiles'

if [[ -d $HOME/.local/bin ]] ; then 
  export PATH=$HOME/.local/bin:$PATH
fi 

if [[ -d /opt/homebrew/bin ]] ; then
  export PATH=/opt/homebrew/bin:$PATH
fi

if command -v starship > /dev/null ; then
  eval "$(starship init bash)"
fi

bind -x '"\C-f": tmux-sessionizer'
