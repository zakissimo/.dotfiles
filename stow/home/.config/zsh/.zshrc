[[ ! -e ${ZIM_HOME}/zimfw.zsh ]] \
    && curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh

[[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]] \
    && source ${ZIM_HOME}/zimfw.zsh init -q

source ${ZIM_HOME}/init.zsh

bindkey -e

[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh

[[ -f "$HOME"/.env ]] && source "$HOME"/.env

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

KEYTIMEOUT=1

alias -- 'la'='eza -la'
alias -- 'lg'='lazygit'
alias -- 'll'='eza -RTXF --git --icons'
alias -- 'ls'='eza'
alias -- 'v'='nvim'
alias -- 'yayf'="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
