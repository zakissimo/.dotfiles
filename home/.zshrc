[[ ! -f $HOME/.config/tmux/tmux.zsh ]] || source $HOME/.config/tmux/tmux.zsh

plugins=(
	git
	history-substring-search
	colored-man-pages
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-z
	fzf
)

[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh
[[ ! -f $ZSH/oh-my-zsh.sh ]] || source $ZSH/oh-my-zsh.sh

alias ls=exa
alias la='exa -la'
alias lg=lazygit
alias t=tmux
alias v=nvim
alias pacf='pacman -Slq | fzf --multi --preview '\''cat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")'\'' | xargs -ro sudo pacman -S'
alias yayf='yay -Slq | fzf --multi --preview '\''cat <(yay -Si {1}) <(yay -l {1} | awk "{print \$2}")'\'' | xargs -ro yay -S'

KEYTIMEOUT=1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
