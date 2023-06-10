export XDG_CACHE_HOME="$HOME/.cache/"
export XDG_CONFIG_HOME="$HOME/.config/"

export ZIM_HOME="$XDG_CACHE_HOME/zim"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_CACHE_HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt appendhistory

export FZF_DEFAULT_OPTS="--multi --layout=reverse --inline-info --height=80%"
export FZF_DEFAULT_COMMAND="rg --files --hidden --ignore-file $XDG_CONFIG_HOME/.ignore 2>/dev/null"

export EDITOR="nvim"
