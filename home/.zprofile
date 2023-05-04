_add_path() { [ -d "$1" ] && export PATH="$PATH:$1" }

_add_path "$HOME/.bin"
_add_path "$HOME/.local/bin"
_add_path "$HOME/.cargo/bin"
_add_path "$PNPM_HOME"

mdir() { mkdir $1 && cd $1 }

mvf() { mv $(fzf) $(find . -type d | fzf) }

[ "$(tty)" = "/dev/tty1" ] && exec Hyprland

# export DRI_PRIME=1
