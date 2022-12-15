if [ -d "$HOME/.bin" ] ;
  then export PATH="$PATH:$HOME/.bin"
fi

if [ -d "$HOME/.local/bin" ] ;
  then export PATH="$PATH:$HOME/.local/bin"
fi

if [ -d "$HOME/Apps" ] ;
  then export PATH="$PATH:$HOME/Apps"
fi

if [ -d "$HOME/.cargo/bin" ] ;
  then export PATH="$PATH:$HOME/.cargo/bin"
fi

# export DRI_PRIME=1
