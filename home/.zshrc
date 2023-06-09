source "$HOME/.config/tmux/tmux.zsh"

export ZIM_HOME="$HOME/.cache/zim"
export FZF_DEFAULT_OPTS="--multi --layout=reverse --inline-info --height=80%"
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!{**/node_modules/*,**/.git/*}' 2>/dev/null"

if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

source ${ZIM_HOME}/init.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

xset r rate 300 50
setxkbmap -option "ctrl:nocaps"

KEYTIMEOUT=1

alias lg=lazygit
alias ls=exa
alias la='exa -la'
alias tree='exa -T'
alias t=tmux
alias v=nvim
alias vim=nvim
