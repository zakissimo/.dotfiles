# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
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
alias pacfzf='pacman -Slq | fzf --multi --preview '\''cat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")'\'' | xargs -ro sudoj pacman -S'
alias yayfzf='yay -Slq | fzf --multi --preview '\''cat <(yay -Si {1}) <(yay -l {1} | awk "{print \$2}")'\'' | xargs -ro yay -S'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
