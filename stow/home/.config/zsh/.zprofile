_add_path() { [ -d "$1" ] && export PATH="$PATH:$1"; }
_add_xdg_data_dir() {
  [ -d "$1" ] && export XDG_DATA_DIRS="$1${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
}

_add_path "$HOME/.bin"
_add_path "$HOME/.local/bin"
_add_path "$HOME/.cargo/bin"
_add_path "$PNPM_HOME"
_add_path "$BUN_INSTALL/bin"
_add_path "$FNM_PATH"
_add_path "/var/lib/snapd/snap/bin"

_add_xdg_data_dir "/var/lib/flatpak/exports/share"
_add_xdg_data_dir "$HOME/.local/share/flatpak/exports/share"
