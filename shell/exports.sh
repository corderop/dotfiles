source "$DOTFILES_PATH/shell/exports.private.sh"

# ------------------------------------------------------------------------------
# General
# ------------------------------------------------------------------------------
export DEV_HOME="~/Software"

# ------------------------------------------------------------------------------
# Languages
# ------------------------------------------------------------------------------
# Python
export PYENV_ROOT="~/.pyenv"
# Javascript
export PNPM_HOME="~/Library/pnpm"
# Rust
export CARGO_HOME="~/.cargo"
. "$HOME/.cargo/env"

# ------------------------------------------------------------------------------
# Apps
# ------------------------------------------------------------------------------
export HOMEBREW_PREFIX="/opt/homebrew"
export DAILY_DRIVER_EDITOR="antigravity"
export ANTIGRAVITY_PATH="~/.antigravity"
export OPENCODE_PATH="~/.opencode"

# ------------------------------------------------------------------------------
# Path - The higher it is, the more priority it has
# ------------------------------------------------------------------------------
path=(
	"$DOTLY_PATH/bin"
	"$DOTFILES_PATH/bin"
	"~/bin"
	"~/.local/bin" # Added by pipx
	"$PYENV_ROOT/bin"
	"$PNPM_HOME"
	"$CARGO_HOME/bin"
	"$OPENCODE_PATH/bin"
	"$ANTIGRAVITY_PATH/antigravity/bin"
	"$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin"
	"$HOMEBREW_PREFIX/bin"
	"/usr/local/bin"
	"/usr/local/sbin"
	"/bin"
	"/usr/bin"
	"/usr/sbin"
	"/sbin"
	"$path"
)

export path
