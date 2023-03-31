_add_path()
{
	[ -d "$1" ] && export PATH="$1:$PATH";
}

_add_path "$HOME/.bin" 
_add_path "$HOME/.local/bin" 
_add_path "$HOME/.cargo/bin" 

[ "$(tty)" = "/dev/tty1" ] && exec Hyprland

# export DRI_PRIME=1
