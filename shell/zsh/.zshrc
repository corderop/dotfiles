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
  poetry
)

### OTHER
source $ZSH/oh-my-zsh.sh

### DOCKER & K8s
function init_docker() {
  source <(kubectl completion zsh)
  colima start
}

### PYENV
export PATH="$HOME/.pyenv/bin:$PATH"

function enable_pyenv() {
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
}

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

init_node () {
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

  nvm use

  # pnpm
  export PNPM_HOME="/Users/$USER/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
  # pnpm end
}

# Created by `pipx` on 2023-10-24 07:23:59
export PATH="$PATH:/Users/$USER/.local/bin"


# pnpm
export PNPM_HOME="/Users/pcordero/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
