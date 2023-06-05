source "$HOME/.config/tmux/tmux.zsh"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "$HOME/zsh/keys.zsh" ]]; then
	source "$HOME/zsh/keys.zsh"
fi

export ZSH="$HOME/.config/oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"
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
)

key

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setxkbmap -option "ctrl:nocaps"

KEYTIMEOUT=1

alias superminival="valgrind --leak-check=full --show-leak-kinds=all --trace-children=yes --track-fds=yes --suppressions=$HOME/Code/wip/minishell/vsupp"
alias minival="valgrind --trace-children=yes --track-fds=yes --suppressions=vsupp"
alias lg=lazygit
alias ls=exa
alias la='exa -la'
alias tree='exa -T'
alias t=tmux
alias lf=lf-ueberzug
alias v=nvim
alias vim=nvim
alias pacfzf='pacman -Slq | fzf --multi --preview '\''cat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")'\'' | xargs -ro sudoj pacman -S'
alias yayfzf='yay -Slq | fzf --multi --preview '\''cat <(yay -Si {1}) <(yay -l {1} | awk "{print \$2}")'\'' | xargs -ro yay -S'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
