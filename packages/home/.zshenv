export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export VISUAL="nvim"
export TERM="xterm-256color"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZIM_HOME="$XDG_CACHE_HOME/zim"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/.zcompdump-$HOST"
export HISTFILE="$XDG_CACHE_HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

export GOPATH="$XDG_CONFIG_HOME/go"
export PNPM_HOME="$XDG_CONFIG_HOME/pnpm"
export BUN_INSTALL="$XDG_CONFIG_HOME/bun"
export FNM_PATH="$HOME/.local/share/fnm"

export CLAUDE_CODE_EFFORT_LEVEL=max

# Idempotent so subshells don't grow PATH/XDG_DATA_DIRS on every re-source.
_prepend_path() {
  [ -d "$1" ] || return
  case ":$PATH:" in
    *":$1:"*) ;;
    *) export PATH="$1${PATH:+:$PATH}" ;;
  esac
}
_prepend_xdg_data_dir() {
  [ -d "$1" ] || return
  case ":$XDG_DATA_DIRS:" in
    *":$1:"*) ;;
    *) export XDG_DATA_DIRS="$1${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}" ;;
  esac
}

_prepend_path "/var/lib/snapd/snap/bin"
_prepend_path "$FNM_PATH"
_prepend_path "$BUN_INSTALL/bin"
_prepend_path "$PNPM_HOME"
_prepend_path "$HOME/.cargo/bin"
_prepend_path "$HOME/.local/bin"
_prepend_path "$HOME/.bin"

_prepend_xdg_data_dir "$HOME/.local/share/flatpak/exports/share"
_prepend_xdg_data_dir "/var/lib/flatpak/exports/share"

unset -f _prepend_path _prepend_xdg_data_dir
