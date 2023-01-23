export ZSH="$HOME/.config/oh-my-zsh"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export FZF_DEFAULT_OPTS="--multi --layout=reverse --inline-info --height=80%"
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!{**/node_modules/*,**/.git/*}' 2>/dev/null"

export USER='zhabri'
export MAIL='zhabri@student.42.fr'

plugins=(
	git
	history-substring-search
	colored-man-pages
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-z
	vi-mode
)

key

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

KEYTIMEOUT=1

alias superminival="valgrind --leak-check=full --show-leak-kinds=all --trace-children=yes --track-fds=yes --suppressions=$HOME/Code/wip/minishell/vsupp"
alias minival="valgrind --trace-children=yes --track-fds=yes --suppressions=vsupp"
alias lg=lazygit
alias ls=exa
alias la='exa -la'
alias t=tmux
alias lf=lf-ueberzug
alias e=emacs
alias v=nvim
alias vim=nvim

eval "$(starship init zsh)"
