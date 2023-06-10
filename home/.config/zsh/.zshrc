source "$HOME/.config/tmux/tmux.zsh"

if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

source ${ZIM_HOME}/init.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ls=exa
alias la='exa -la'
alias tree='exa -T'
alias lg=lazygit
alias t=tmux
alias v=nvim
alias vim=nvim

bindkey -e
KEYTIMEOUT=1
xset r rate 300 50
setxkbmap -option "ctrl:nocaps"
