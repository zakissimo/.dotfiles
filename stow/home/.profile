export SHELL=`which zsh`
[ -z "$ZSH_VERSION" ] && exec "$SHELL" -l
. "$HOME/.cargo/env"
