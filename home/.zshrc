export ZSH="$HOME/.config/oh-my-zsh"
export ZSH_THEME="robbyrussell"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export FZF_DEFAULT_OPTS="--multi --layout=reverse --inline-info --height=80%"
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!{**/node_modules/*,**/.git/*}' 2>/dev/null"

plugins=(
    git
    history-substring-search
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
)

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

KEYTIMEOUT=1

alias lg=lazygit
alias ls=exa
alias la='exa -la'
alias t=tmux
alias lf=lf-ueberzug
alias e=emacs
alias v=nvim
alias vim=nvim

eval "$(zoxide init zsh)"

source "$HOME/.config/tmux/tmux.sh"
