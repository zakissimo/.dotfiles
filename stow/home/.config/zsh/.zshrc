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
setopt appendhistory

export FZF_DEFAULT_OPTS="--multi --layout=reverse --inline-info --height=80%"
export FZF_DEFAULT_COMMAND="rg --files --hidden --ignore-file $XDG_CONFIG_HOME/.ignore 2>/dev/null"

bindkey -e
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

alias -- 'la'='eza -la'
alias -- 'lg'='lazygit'
alias -- 'll'='eza -RTXF --git --icons'
alias -- 'ls'='eza'
alias -- 'v'='nvim'
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

mdir() { mkdir $1 && cd $1 }

mvf() { mv $(fzf) $(find . -type d | fzf) }

zel () {
    echo -n "\033]1337;SetUserVar=IN_ZELLIJ=MQo\007"
    command zellij attach -c Z
    echo -n "\x1b]1337;SetUserVar=IN_ZELLIJ\007"
}

zellij () {
    echo -n "\033]1337;SetUserVar=IN_ZELLIJ=MQo\007"
    command zellij $@
    echo -n "\x1b]1337;SetUserVar=IN_ZELLIJ\007"
}

eval "$(starship init zsh)"
