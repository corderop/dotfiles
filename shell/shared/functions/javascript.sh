function init_nvm () {
  if [ -z "${NVM_DIR+x}" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  fi
}

function init_pnpm () {
  # pnpm
  export PNPM_HOME="/Users/$USER/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
  # pnpm end
}

if [ -n "${BASH_VERSION:-}" ]; then
  source "$DOTFILES_PATH/shell/shared/functions/javascript/javascript.bash.sh"
else
  source "$DOTFILES_PATH/shell/shared/functions/javascript/javascript.zsh.sh"
fi
