_add_path()
{
	[ -d "$1" ] && export PATH="$1:$PATH";
}

[ "$(tty)" = "/dev/tty1" ] && exec Hyprland

_add_path "$HOME/Apps" 
_add_path "$HOME/.bin" 
_add_path "$HOME/.local/bin" 
_add_path "$HOME/.cargo/bin" 

alias ls=exa
alias la='exa -la'
alias lg=lazygit
alias e=emacs
alias t=tmux
alias v=nvim
alias mpv='devour mpv'
alias pacfzf='pacman -Slq | fzf --multi --preview '\''cat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")'\'' | xargs -ro sudo pacman -S'
alias yayfzf='yay -Slq | fzf --multi --preview '\''cat <(yay -Si {1}) <(yay -l {1} | awk "{print \$2}")'\'' | xargs -ro yay -S'

# export DRI_PRIME=1
