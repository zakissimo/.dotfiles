export XDG_CACHE_HOME="$HOME/.cache/"
export XDG_CONFIG_HOME="$HOME/.config/"

export ZIM_HOME="$HOME/.cache/zim"
export ZDOTDIR="$HOME/.config/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/.zcompdump-$HOST"

export FZF_DEFAULT_OPTS="--multi --layout=reverse --inline-info --height=80%"
export FZF_DEFAULT_COMMAND="rg --files --hidden --ignore-file $XDG_CONFIG_HOME/.ignore 2>/dev/null"

export EDITOR="nvim"

bindkey -e
xset r rate 300 50
setxkbmap -option "ctrl:nocaps"

KEYTIMEOUT=1

alias ls=exa
alias la='exa -la'
alias tree='exa -T'
alias lg=lazygit
alias t=tmux
alias v=nvim
alias vim=nvim
