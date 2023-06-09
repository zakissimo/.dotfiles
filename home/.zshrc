[[ ! -f $HOME/.config/tmux/tmux.zsh ]] || source $HOME/.config/tmux/tmux.zsh

if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

source ${ZIM_HOME}/init.zsh

[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh

alias ls=exa
alias la='exa -la'
alias lg=lazygit
alias t=tmux
alias v=nvim
alias pacf='pacman -Slq | fzf --multi --preview '\''cat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")'\'' | xargs -ro sudo pacman -S'
alias yayf='yay -Slq | fzf --multi --preview '\''cat <(yay -Si {1}) <(yay -l {1} | awk "{print \$2}")'\'' | xargs -ro yay -S'

bindkey -e

KEYTIMEOUT=1
