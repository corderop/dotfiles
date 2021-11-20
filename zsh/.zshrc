export ZSH="/home/pcordero/.oh-my-zsh"

ZSH_THEME="robbyrussell"

### UPDATES
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

### FEATURES
ENABLE_CORRECTION="true" # enable auto-correction to misspelling comands
DISABLE_UNTRACKED_FILES_DIRTY="true" # make repository check faster

### PLUGINS
plugins=(
  git
)

### OTHER
source $ZSH/oh-my-zsh.sh
