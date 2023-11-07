_add_path() { [ -d "$1" ] && export PATH="$PATH:$1" }

_add_path "$HOME/.bin"
_add_path "$HOME/.local/bin"
_add_path "$HOME/.cargo/bin"
_add_path "$PNPM_HOME"

mdir() { mkdir $1 && cd $1 }

mvf() { mv $(fzf) $(find . -type d | fzf) }

xset r rate 300 50
setxkbmap -model pc105 -layout us_qwerty-fr,ara -option grp:alt_shift_toggle
# Caps lock is now ctrl
setxkbmap -option ctrl:nocaps
