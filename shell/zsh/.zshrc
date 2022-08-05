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

# DOTFILES
DOTFILES_PATH="$HOME/.dotfiles"

## Load dotfiles shell configuration
source ${DOTFILES_PATH}/shell/init.sh
