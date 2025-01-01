[[ ! -e ${ZIM_HOME}/zimfw.zsh ]] \
    && curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh

[[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]] \
    && source ${ZIM_HOME}/zimfw.zsh init -q

[ -s "$ZIM_HOME/init.zsh" ] && source "$ZIM_HOME/init.zsh"
[ -s "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
[ -d "$FNM_PATH" ] && eval "`fnm env`"
[ -s "$HOME/.env" ] && source "$HOME/.env"

[ -n "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && xset r rate 200 50

KEYTIMEOUT=1

bindkey -e
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

alias -- 'la'='eza -la'
alias -- 'lg'='lazygit'
alias -- 'll'='eza -RTXF --git --icons'
alias -- 'ls'='eza'
alias -- 'v'='nvim'
alias -- 'yayf'="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"

eval "$(zellij setup --generate-auto-start zsh)"
