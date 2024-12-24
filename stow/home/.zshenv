export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export VISUAL="neovide"
export TERMINAL="wezterm"
export BROWSER="firefox"

# export WLR_NO_HARDWARE_CURSORS="1"
# export MOZ_ENABLE_WAYLAND="1"
# export _JAVA_AWT_WM_NONREPARENTING="1"

export XDG_CURRENT_DESKTOP="Hyprland"
export XDG_SESSION_DESKTOP="Hyprland"
export XDG_SESSION_TYPE="wayland"
export GTK_USE_PORTAL="1"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

# export WLR_RENDERER="vulkan"
# export GDK_BACKEND="wayland,x11"
# export SDL_VIDEODRIVER=wayland
# export CLUTTER_BACKEND=wayland

export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

export ZIM_HOME="$XDG_CACHE_HOME/zim"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/.zcompdump-$HOST"
export HISTFILE="$XDG_CACHE_HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt appendhistory

export GOPATH="$XDG_CONFIG_HOME/go"
export PNPM_HOME="$XDG_CONFIG_HOME/pnpm"
export BUN_INSTALL="$XDG_CONFIG_HOME/bun"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export FNM_PATH="$HOME/.local/share/fnm"

export FZF_DEFAULT_OPTS="--multi --layout=reverse --inline-info --height=80%"
export FZF_DEFAULT_COMMAND="rg --files --hidden --ignore-file $XDG_CONFIG_HOME/.ignore 2>/dev/null"
