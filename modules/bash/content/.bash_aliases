
alias ls='ls -a --color=auto'
alias grep='grep --color=auto'

if uname -r | grep -iq wsl; then
    W_SYSTEM_ROOT="/mnt/c/Windows/"
    alias whome="cd /mnt/c/Users/mia-antonion"
    alias wrepo="cd /mnt/c/Users/mia-antonion/repos"
    alias wnotes="cd /mnt/c/Users/mia-antonion/OneDrive\ -\ Expeditors\ International\ of\ Washington\ Inc/Documents/Obsidian/Personal"
    alias wwnotes="cd /mnt/c/Users/mia-antonion/Expeditors\ International\ of\ Washington\ Inc/Americas\ IS-Solutions\ Team\ -\ CSP\ Business\ Apps/CSP_Business_Apps_Obsidian_Vault/"
    alias wcode="/mnt/c/Users/mia-antonion/AppData/Local/Programs/Microsoft\ VS\ Code/Code.exe"
    alias setnoproxy="$(eval proxy --no)"
    alias setproxy="$(eval proxy --yes)"
fi

# =========================================
# Git Stuff
# =========================================
alias g=git
alias ga="git add"
alias gs="git status"
alias gh="git hist"
alias gha="git ahist"
alias gl="git pull"
alias gp="git push"
alias gb="git branch"
alias gck="git checkout"
alias gsw="git switch"
alias gc="git commit"
alias gd="git diff"
alias gdc="git diff --cached"
alias gsh="git stash"
alias gshp="git stash pop"
alias gshd="git stash drop"

# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
alias ggpush='git push origin $(current_branch)'

#Git Aliases AutoComplete
type __git_complete >/dev/null 2>&1 && {
    __git_complete   g        _git
    __git_complete   ga       _git_add
    __git_complete   gh       _git_log
    __git_complete   gha      _git_log
    __git_complete   gl       _git_pull
    __git_complete   gp       _git_push
    __git_complete   gb       _git_branch
    __git_complete   gck      _git_checkout
    __git_complete   gsw      _git_switch
    __git_complete   gc       _git_commit
    __git_complete   gd       _git_diff
    __git_complete   gdc      _git_diff
}
