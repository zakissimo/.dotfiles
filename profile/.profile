export EDITOR=nvim
export VISUAL=code
export BROWSER=brave

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/apps" ] ;
  then PATH="$HOME/apps:$PATH"
fi

# [[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx --vti
