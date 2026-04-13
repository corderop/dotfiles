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