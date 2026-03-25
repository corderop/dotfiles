function init_nvm () {
  if [[ ! -v NVM_DIR ]]; then 
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

function nvm {
  unfunction nvm
  init_nvm
  $0 "$@"
}

function pnpm pnpx {
  unfunction pnpm pnpx
  init_pnpm
  nvm use
  $0 "$@"
}

function node npm npx yarn {
  unfunction node npm npx yarn
  nvm use
  $0 "$@"
}
