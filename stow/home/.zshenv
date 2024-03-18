export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

export ZIM_HOME="$XDG_CACHE_HOME/zim"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/.zcompdump-$HOST"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export HISTFILE="$XDG_CACHE_HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt appendhistory

export EDITOR="nvim"
export TERM="xterm"
export TERMINAL="xterm"

export GOPATH="$XDG_CONFIG_HOME/go"
export PNPM_HOME="/home/zak/.local/share/pnpm"

export FZF_DEFAULT_OPTS="--multi --layout=reverse --inline-info --height=80%"
export FZF_DEFAULT_COMMAND="rg --files --hidden --ignore-file $XDG_CONFIG_HOME/.ignore 2>/dev/null"

[ -f "$HOME/.zshrc" ] && rm -rf "$HOME/.zshrc"
