# ------------------------------------------------------------------------------
# Languages
# ------------------------------------------------------------------------------
# Python
export PYENV_ROOT="$HOME/.pyenv"
export PNPM_HOME="$HOME/Library/pnpm"

# ------------------------------------------------------------------------------
# Apps
# ------------------------------------------------------------------------------
export DAILY_DRIVER_EDITOR="antigravity"
export ANTIGRAVITY_PATH="$HOME/.antigravity"
export OPENCODE_PATH="$HOME/.opencode"

# ------------------------------------------------------------------------------
# Path - The higher it is, the more priority it has
# ------------------------------------------------------------------------------
path=(
	"$DOTLY_PATH/bin"
	"$DOTFILES_PATH/bin"
	"$HOME/bin"
	"$HOME/.local/bin" # Added by pipx
	"$PYENV_ROOT/bin"
	"$PNPM_HOME"
	"$OPENCODE_PATH/bin"
	"$ANTIGRAVITY_PATH/antigravity/bin"
	"/opt/homebrew/bin"
	"/usr/local/bin"
	"/usr/local/sbin"
	"/bin"
	"/usr/bin"
	"/usr/sbin"
	"/sbin"
	"$path"
)

export path
