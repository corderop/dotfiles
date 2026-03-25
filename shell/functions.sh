source "$DOTFILES_PATH/shell/shared/functions/init.sh"

function cdd() {
	cd "$(ls -d -- */ | fzf)" || echo "Invalid directory"
}

function recent_dirs() {
	# This script depends on pushd. It works better with autopush enabled in ZSH
	escaped_home=$(echo $HOME | sed 's/\//\\\//g')
	selected=$(dirs -p | sort -u | fzf)

	cd "$(echo "$selected" | sed "s/\~/$escaped_home/")" || echo "Invalid directory"
}

function enable_pyenv() {
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
}

### DOCKER & K8s
function init_docker() {
  source <(kubectl completion zsh)
  colima start
}

