export LANG="en_US.UTF-8"
export HISTSIZE=60000
export HISTCONTROL=ignoreboth:erasedups

set -o vi
set -o history

alias ls='ls --color=auto -a'
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

if uname -r | grep -iq wsl ; then
    if command -v proxy > /dev/null ; then
        eval "$(proxy --yes)"
    fi
fi

[[ -f "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"
[[ -f "$HOME/.bash_containers" ]] && source "$HOME/.bash_containers"
[[ -f "$HOME/.bash_env" ]] && source "$HOME/.bash_env"

if command -v tms > /dev/null ; then
  bind -x '"\C-f": tms dir'
  bind -x '"\C-j": tms ssh'
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
