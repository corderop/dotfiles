# Useful commands for presentations. It allows to navigate through the commits so 
# that you can show the evolution of the code.

# Checkout previous commit
git_prev() {
    git checkout HEAD~
}

# Checkout next commit
git_next() {
    BRANCH=$1
    if [ -z $1 ]; 
    then
        BRANCH='main'
    fi

    git log --reverse --pretty=%H $BRANCH | grep -A 1 $(git rev-parse HEAD) | tail -n1 | xargs git checkout
}