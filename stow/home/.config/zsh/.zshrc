[[ ! -e ${ZIM_HOME}/zimfw.zsh ]] \
    && curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh

[[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]] \
    && source ${ZIM_HOME}/zimfw.zsh init -q

[ -s "$ZIM_HOME/init.zsh" ] && source "$ZIM_HOME/init.zsh"
[ -s "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
[ -d "$FNM_PATH" ] && eval "`fnm env`"
[ -s "$HOME/.env" ] && source "$HOME/.env"

KEYTIMEOUT=1

bindkey -e
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

alias -- 'la'='eza -la'
alias -- 'lg'='lazygit'
alias -- 'll'='eza -RTXF --git --icons'
alias -- 'ls'='eza'
alias -- 'v'='nvim'
alias -- 'zel'='zellij attach -c Z'
alias -- 'yayf'="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"

zellij_tab_name_update() {
  if [[ -n $ZELLIJ ]]; then
    tab_name=''
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        tab_name+=$(basename "$(git rev-parse --show-toplevel)")/
        tab_name+=$(git rev-parse --show-prefix)
        tab_name=${tab_name%/}
    else
        tab_name=$PWD
            if [[ $tab_name == $HOME ]]; then
            tab_name="~"
             else
            tab_name=${tab_name##*/}
             fi
    fi
    zellij action rename-tab $tab_name >/dev/null 2>&1
  fi
}

chpwd() {
  zellij_tab_name_update
}

precmd() {
  zellij_tab_name_update
}
