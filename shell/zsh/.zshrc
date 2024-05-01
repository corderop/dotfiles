export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

### UPDATES
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

### FEATURES
ENABLE_CORRECTION="true" # enable auto-correction to misspelling comands
DISABLE_UNTRACKED_FILES_DIRTY="true" # make repository check faster

### PLUGINS
export NVM_LAZY=1
plugins=(
  git
  zsh-autosuggestions
)

### OTHER
source $ZSH/oh-my-zsh.sh

### PYENV
export PATH="$HOME/.pyenv/bin:$PATH"

function enable_pyenv() {
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
}

### ALIAS
alias docker-service-start="service docker start"

# GIT ALIAS
alias g="git"
alias gs="git status"
alias ga="git add"
alias ga.="git add ."
alias gc="git commit"
alias gca="ga. && gc"
alias gcam="git commit --amend"
alias gcaam="ga. && git commit --amend"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gpl="git pull"
alias gps="git push"
alias gpf="git push --force-with-lease"
alias gpsu="git push --set-upstream origin"
alias gl="git log --oneline --decorate --graph --all"
alias gfa="git fetch --all"
alias grc="git rebase --committer-date-is-author-date"

# MAC OS
eval $(/opt/homebrew/bin/brew shellenv)

# pnpm
export PNPM_HOME="/Users/corderop/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# Created by `pipx` on 2023-10-24 07:23:59
export PATH="$PATH:/Users/corderop/.local/bin"
