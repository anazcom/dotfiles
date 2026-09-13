LANG="en_US.UTF-8" # Language locale setup
HISTSIZE=1000 # Number of commands kept in memory for the current shell session.
HISTFILE=~/.zhistfile # History file location.
SAVEHIST=1000 # Maximum commands written to disk.

setopt SHARE_HISTORY # Share history between all open terminals
setopt HIST_IGNORE_DUPS # Ignore duplicate entries
setopt HIST_REDUCE_BLANKS # Remove unnecessary spaces before saving history.
setopt AUTO_CD # Allows `~/projects` instead of `cd ~/projects`
setopt CORRECT # Suggest corrections for commands.
setopt PROMPT_SUBST # Enable prompt substitution

ZSH_FUNCTIONS="$HOME/.config/zsh/functions"
# autoload: Register a function for lazy loading
# -U: Do not perform alias expansion while loading
# -z: Mark this as a Zsh-style function
autoload -Uz vcs_info
autoload -Uz compinit && compinit
autoload -Uz colors && colors
if [[ -d "$ZSH_FUNCTIONS" ]]; then
    fpath+=("$ZSH_FUNCTIONS")
    autoload -Uz ksm
    autoload -Uz trivy
    autoload -Uz postgres
    autoload -Uz finder
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Case insensitive completion.
zstyle ':completion:*' use-cache yes # Cache completion results for better performance.
zstyle ':vcs_info:git:*' formats '(%b)' # Configure git branch display

precmd() {
    vcs_info
}

# Prompt format
# %~   -> current directory
# %#   -> prompt character
# %1   -> prompt folder name
PROMPT='%F{cyan}%1~%f %F{green}${vcs_info_msg_0_}%f %# '

if [[ -d $HOME/.local/bin ]] ; then 
  export PATH=$HOME/.local/bin:$PATH
fi 

bindkey -v # Use vim keymaps
# bindkey -s '^f' '^ufinder\r'
bindkey -M vicmd '/' history-incremental-search-backward

if command -v tmux-sessionizer >/dev/null 2>&1; then
    bindkey -s '^f' '^utmux-sessionizer\r'
fi

if command -v servers >/dev/null 2>&1; then
    bindkey -s '^j' '^uservers\r'
fi

if command -v curl >/dev/null 2>&1; then
    export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
fi


if [[ -d "/mnt/c/Users/mia-antonion/AppData/Local/Programs/Microsoft VS Code/bin" ]] ; then
    export PATH="$PATH:/mnt/c/Users/mia-antonion/AppData/Local/Programs/Microsoft VS Code/bin"
fi

if [[ -d /opt/homebrew/bin ]] ; then
  export PATH=/opt/homebrew/bin:$PATH
fi

if uname -r | grep -iq wsl ; then
    if command -v proxy > /dev/null ; then
        eval "$(proxy --yes)"
    fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias ls='ls -a --color=auto'
alias grep='grep --color=auto'
alias ..="cd .."
if uname -r | grep -iq wsl; then
    W_SYSTEM_ROOT="/mnt/c/Windows/"
    alias whome="cd /mnt/c/Users/mia-antonion"
    alias wrepo="cd /mnt/c/Users/mia-antonion/repos"
    alias wnotes="cd /mnt/c/Users/mia-antonion/OneDrive\ -\ Expeditors\ International\ of\ Washington\ Inc/Documents/Obsidian/Personal"
    alias wwnotes="cd /mnt/c/Users/mia-antonion/Expeditors\ International\ of\ Washington\ Inc/Americas\ IS-Solutions\ Team\ -\ CSP\ Business\ Apps/CSP_Business_Apps_Obsidian_Vault/"
    alias wcode="/mnt/c/Users/mia-antonion/AppData/Local/Programs/Microsoft\ VS\ Code/Code.exe"
    alias setnoproxy="$(eval proxy --no)"
    alias setproxy="$(eval proxy --yes)"
    alias wexplorer="/mnt/c/Windows/explorer.exe"
fi
