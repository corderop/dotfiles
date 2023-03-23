# OH-MY-ZSH
export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="robbyrussell"

## FEATURES
DISABLE_UNTRACKED_FILES_DIRTY="true" # make git repository check faster

## UPDATES
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

## PLUGINS
plugins=(
  git
  zsh-autosuggestions
)

## OTHER
source $ZSH/oh-my-zsh.sh

# GIT ALIAS
alias g="git"
alias gs="git status"
alias ga="git add"
alias ga.="git add ."
alias gc="git commit"
alias gca="git commit -a"
alias gcam="git commit --amend"
alias gcaam="git commit -a --amend"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gpl="git pull"
alias gps="git push"
alias gpf="git push --force-with-lease"
alias gpsu="git push --set-upstream origin"
alias gl="git log --oneline --decorate --graph --all"

# DOTFILES
DOTFILES_PATH="$HOME/.dotfiles"

## Load dotfiles shell configuration
source ${DOTFILES_PATH}/shell/init.sh
