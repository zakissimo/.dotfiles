_add_path() { [ -d "$1" ] && export PATH="$1:$PATH" }
_add_include() { [ -d "$1" ] && export C_INCLUDE_PATH="$C_INCLUDE_PATH:$1" }

_add_path "$HOME/.bin"
_add_path "$HOME/.local/bin"
_add_path "$HOME/.cargo/bin"
_add_path "$HOME/opt/Qt/Tools/QtCreator/bin"
_add_path "$HOME/opt/Qt/Tools/Ninja/bin"
_add_path "$HOME/opt/Qt/Tools/QtDesignStudio/bin"
_add_path "$HOME/opt/Qt/5.15.2/gcc_64/bin"
_add_path "$PNPM_HOME"

_add_include "$HOME/opt/Qt/5.15.2/gcc_64/include"

mdir() { mkdir $1 && cd $1 }

mvf() { mv $(fzf) $(find . -type d | fzf) }
