_add_path()
{
	[ -d "$1" ] && export PATH="$1:$PATH";
}

[ "$(tty)" = "/dev/tty1" ] && exec Hyprland

_add_path "$HOME/Apps" 
_add_path "$HOME/.bin" 
_add_path "$HOME/.local/bin" 
_add_path "$HOME/.cargo/bin" 

# export DRI_PRIME=1
