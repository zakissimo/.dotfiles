__add_path()
{
	[ -d "$1" ] && export PATH="$1:$PATH";
}

__add_path "$HOME/.bin" 
__add_path "$HOME/.local/bin" 
__add_path "$HOME/Apps" 
__add_path "$HOME/.cargo/bin" 

# export DRI_PRIME=1
