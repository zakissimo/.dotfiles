[[ ! -e ${ZIM_HOME}/zimfw.zsh ]] \
    && curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh

[[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]] \
    && source ${ZIM_HOME}/zimfw.zsh init -q

source ${ZIM_HOME}/init.zsh

source ${ZDOTDIR}/.zprofile

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

[[ -f ~/.env ]] && source ~/.env

alias ls=exa
alias la='exa -la'
alias ll='exa -T --icons'
alias lg=lazygit
alias v=nvim
alias yayf="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"

xset r rate 300 50
# Caps lock is now ctrl
setxkbmap -option ctrl:nocaps
bindkey -e

#Colored man pages
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blinking
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # end mode
export LESS_TERMCAP_se=$'\E[0m'        # end standout-mode
export LESS_TERMCAP_so=$'\E[1;40;92m'  # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'        # end underline
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline

KEYTIMEOUT=1

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
