# source "$HOME"/.zprofile
export ZSH="$HOME/.config/oh-my-zsh"
export FZF_DEFAULT_OPTS="--multi --layout=reverse --inline-info --height=80%"
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!{**/node_modules/*,**/.git/*}' 2>/dev/null"

export USER='zhabri'
export MAIL='zhabri@student.42.fr'

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

alias lg=lazygit
#alias ls=exa
alias lf=lf-ueberzug
#alias la='exa -la'
alias v=nvim
alias vim=nvim
alias gw=gcc -Wall -Wextra -Werror
alias mpv='devour mpv'

eval "$(starship init zsh)"
