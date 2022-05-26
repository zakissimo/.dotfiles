export ZSH="$HOME/.config/oh-my-zsh"
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export FZF_DEFAULT_OPTS="--multi --layout=reverse --inline-info --height=80%"
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!{**/node_modules/*,**/.git/*}' 2>/dev/null"

plugins=(
    fzf
    git
    history-substring-search
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
	vi-mode
)

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bindkey -e

alias lg=lazygit
alias ls=exa
alias lf=lf-ueberzug
alias la='exa -la'
alias e=emacs
alias v=nvim
alias vim=nvim
alias mpv='devour mpv'
alias pacfzf='pacman -Slq | fzf --multi --preview '\''cat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")'\'' | xargs -ro sudo pacman -S'
alias yayfzf='yay -Slq | fzf --multi --preview '\''cat <(yay -Si {1}) <(yay -l {1} | awk "{print \$2}")'\'' | xargs -ro yay -S'
# alias parufzf='paru -Slq | fzf --multi --preview '\''cat <(paru -Si {1}) <(paru -l {1} | awk "{print \$2}")'\'' | xargs -ro paru -S'

#alias aptfzf='apt-cache pkgnames | fzf --multi --cycle --reverse --preview "apt-cache show {1}" --preview-window=:57%:wrap:hidden --bind=space:toggle-preview | xargs -ro sudo apt install'

# (cat ~/.cache/wal/sequences &)

eval "$(starship init zsh)"
