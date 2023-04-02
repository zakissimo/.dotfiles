# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

source "$HOME/.config/tmux/tmux.zsh"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(
	git
	history-substring-search
	colored-man-pages
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-z
	fzf
)

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ls=exa
alias la='exa -la'
alias lg=lazygit
alias t=tmux
alias v=nvim
alias mpv='devour mpv'
alias pacf='pacman -Slq | fzf --multi --preview '\''cat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")'\'' | xargs -ro sudo pacman -S'
alias yayf='yay -Slq | fzf --multi --preview '\''cat <(yay -Si {1}) <(yay -l {1} | awk "{print \$2}")'\'' | xargs -ro yay -S'

KEYTIMEOUT=1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
