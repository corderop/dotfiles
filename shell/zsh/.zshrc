export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="robbyrussell"

### UPDATES
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

### FEATURES
DISABLE_UNTRACKED_FILES_DIRTY="true" # make git repository check faster

### PLUGINS
plugins=(
  git
  zsh-autosuggestions
)

### OTHER
source $ZSH/oh-my-zsh.sh
source $HOME/.bin/exports.sh
