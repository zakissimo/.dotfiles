plugins=(
	git
	history-substring-search
	colored-man-pages
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-z
	vi-mode
	fzf
)

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

KEYTIMEOUT=1

alias lg=lazygit
alias ls=exa
alias lf=lf-ueberzug
alias la='exa -la'
alias e=emacs
alias t=tmux
alias v=nvim
alias mpv='devour mpv'
alias pacfzf='pacman -Slq | fzf --multi --preview '\''cat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")'\'' | xargs -ro sudo pacman -S'
alias yayfzf='yay -Slq | fzf --multi --preview '\''cat <(yay -Si {1}) <(yay -l {1} | awk "{print \$2}")'\'' | xargs -ro yay -S'


eval "$(starship init zsh)"
# DRI_PRIME=1
