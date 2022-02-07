#!/usr/bin/env sh

export TERM=kitty
export EDITOR=nvim
export VISUAL=code
export BROWSER=brave

if [ -d "$HOME/.bin" ] ;
  then export PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Apps" ] ;
  then export PATH="$HOME/Apps:$PATH"
fi

# [[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx --vti
