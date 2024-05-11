typeset -U path cdpath fpath manpath

bindkey -e

HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="/home/zak/.cache/zsh/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY
setopt autocd

[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh
[[ -f "$HOME"/.env ]] && source "$HOME"/.env
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

KEYTIMEOUT=1

alias -- 'la'='eza -la'
alias -- 'lg'='lazygit'
alias -- 'll'='eza -RTXF --git --icons'
alias -- 'ls'='eza'
alias -- 'v'='nvim'

export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blinking
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # end mode
export LESS_TERMCAP_se=$'\E[0m'        # end standout-mode
export LESS_TERMCAP_so=$'\E[1;40;92m'  # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'        # end underline
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
