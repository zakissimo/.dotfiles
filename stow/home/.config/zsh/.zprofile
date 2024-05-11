_add_path() { [ -d "$1" ] && export PATH="$PATH:$1" }

_add_path "$HOME/.bin"
_add_path "$HOME/.local/bin"
_add_path "$HOME/.cargo/bin"
_add_path "$PNPM_HOME"
_add_path "$BUN_INSTALL/bin"

mdir() { mkdir $1 && cd $1 }

mvf() { mv $(fzf) $(find . -type d | fzf) }

[ "$(tty)" = "/dev/tty1" ] && type Hyprland > /dev/null 2>&1 && exec Hyprland
