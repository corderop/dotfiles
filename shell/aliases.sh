# Enable aliases to be sudo’ed
alias sudo='sudo '

alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -l"
alias la="ls -la"
alias ~="cd ~"
alias dotfiles='cd $DOTFILES_PATH'

# Git
alias gs="git status"
alias ga="git add"
alias ga.="git add ."
alias gc="git commit"
alias gca="ga. && gc"
alias gcam="git commit --amend"
alias gcaam="ga. && git commit --amend"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gfa="git fetch --all"
alias gpl="git pull"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gl='$DOTLY_PATH/bin/dot git pretty-log'
alias grc="git rebase --committer-date-is-author-date"
alias grs="git restore --staged"
alias grs.="git restore --staged ."

# Utils
alias k='kill -9'
alias c.='("$DAILY_DRIVER_EDITOR" $PWD &>/dev/null &)'
alias o.='open .'
alias up='dot package update_all'
