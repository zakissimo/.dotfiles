export ZSH="$HOME/.oh-my-zsh"
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --height=80%"

plugins=(
    fzf
    git
    history-substring-search
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
)

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

set -o vi

alias ls=exa
alias la='exa -la'
alias e=emacs
alias v=nvim
alias vim=nvim
alias pacfzf='pacman -Slq | fzf --multi --preview '\''cat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")'\'' | xargs -ro sudo pacman -S'
alias yayfzf='yay -Slq | fzf -m --preview '\''cat <(yay -Si {1}) <(yay -Fl {1} | awk "{print \$2}")'\'' | xargs -ro  yay -S'

(cat ~/.cache/wal/sequences &)

eval "$(starship init zsh)"
