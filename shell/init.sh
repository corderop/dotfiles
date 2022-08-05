DOTFILES_PATH="$HOME/.dotfiles"

# Aliases
for aliasFile in "$DOTFILES_PATH/shell/_aliases/"*; do source "$aliasFile"; done
# Variables
for varFile in "$DOTFILES_PATH/shell/_variables/"*; do source "$varFile"; done
# Functions
for funcFile in "$DOTFILES_PATH/shell/_functions/"*; do source "$funcFile"; done
