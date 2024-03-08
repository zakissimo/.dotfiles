[[ ! -e ${ZIM_HOME}/zimfw.zsh ]] \
    && curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh

[[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]] \
    && source ${ZIM_HOME}/zimfw.zsh init -q

source ${ZIM_HOME}/init.zsh

[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh

alias ls=exa
alias la='eza -la'
alias ll='eza -RTXF --git --icons'
alias lg=lazygit
alias v=nvim

bindkey -e

KEYTIMEOUT=1
