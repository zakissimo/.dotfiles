{ config, pkgs, ... }:

{
  home.username = "zak";
  home.homeDirectory = "/home/zak";

  home.stateVersion = "23.11";

  home.keyboard.enable = false;

  home.pointerCursor = {
    gtk.enable = true;
    name = "phinger-cursors";
    package = pkgs.phinger-cursors;
    size = 22;
  };

  systemd.user.services = {
    polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "polkit-gnome-authentication-agent-1";
        Wants = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
      Install = { WantedBy = [ "default.target" ]; };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
    iconTheme = {
      name = "rose-pine";
      package = pkgs.rose-pine-icon-theme;
    };
    cursorTheme = {
      name = "phinger-cursors";
      package = pkgs.phinger-cursors;
    };
  };

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "pcmanfm.desktop" ];
    "text/plain" = [ "neovide.desktop" ];
    "application/pdf" = [ "zathura.desktop" ];
    "image/*" = [ "imv.desktop" ];
    "video/png" = [ "mpv.desktop" ];
    "video/jpg" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    asusctl
    brillo
  ];

  home.activation = with pkgs; {
    rmDeadLinks = ''
      find "$HOME/.config" -xtype l -delete
    '';
    linkGtk = ''
      [ ! -L "$HOME/.config/gtk-3.0/gtk.css" ] && ln -s "$HOME/.config/gtk-4.0/gtk.css" "$HOME/.config/gtk-3.0/gtk.css"
    '';
    mkBinDirs = ''
      [ ! -d "$HOME/.bin" ] && mkdir -p "$HOME/.bin"
      [ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin"
    '';
    mkDataDirs = ''
      [ ! -d "$HOME/.local/share" ] && mkdir -p "$HOME/.local/share"
      [ ! -d "$HOME/.local/state" ] && mkdir -p "$HOME/.local/state"
    '';
    mkShellDir = ''
      [ ! -d "$HOME/.config/zsh" ] && mkdir -p "$HOME/.config/zsh"
    '';
    cloneNvimConfig = ''
      [ ! -d "$HOME/.config/nvim" ] && ${git}/bin/git clone "https://github.com/zakissimo/nvim" "$HOME/.config/nvim"
    '';
    cloneAndStow = ''
      [ ! -d "$HOME/.dotfiles" ] && ${git}/bin/git clone -b nix "https://github.com/zakissimo/.dotfiles" "$HOME/.config/.dotfiles"
      sh "$HOME/.dotfiles/bin/stow.sh" "${stow}/bin/stow"
    '';
  };

  programs = {
    git = {
      enable = true;
      userName = "zakissimo";
      userEmail = "zakaria.habri@gmail.com";
    };
    zsh = {
      autocd = true;
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      historySubstringSearch.enable = true;
      syntaxHighlighting.enable = true;

      defaultKeymap = "emacs";
      dotDir = ".config/zsh";

      history.path = "${config.xdg.cacheHome}/zsh/.zsh_history";
      historySubstringSearch = {
        searchDownKey = [ "" "^[[B" ];
        searchUpKey = [ "" "^[[A" ];
      };

      oh-my-zsh = {
        enable = true;
        plugins =
          [
            "colorize"
            "colored-man-pages"
            "git"
            "z"
          ];
        theme = "robbyrussell";
      };

      initExtra = ''
        export NIX_LD="$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')"

        [[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh
        [[ -f "$HOME"/.env ]] && source "$HOME"/.env

        KEYTIMEOUT=1
      '';
      sessionVariables = {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        ZSH_COMPDUMP = "$XDG_CACHE_HOME/.zcompdump-$HOST";
        GOPATH = "$XDG_CONFIG_HOME/go";
        PNPM_HOME = "$XDG_CONFIG_HOME/pnpm";
        FZF_DEFAULT_OPTS = "--multi --layout=reverse --inline-info --height=80%";
        FZF_DEFAULT_COMMAND = "rg --files --hidden --ignore-file $XDG_CONFIG_HOME/.ignore 2>/dev/null";
      };
      profileExtra = ''
        _add_path() { [ -d "$1" ] && export PATH="$PATH:$1" }

        _add_path "$HOME/.bin"
        _add_path "$HOME/.local/bin"
        _add_path "$HOME/.cargo/bin"
        _add_path "$PNPM_HOME"

        mdir() { mkdir $1 && cd $1 }

        mvf() { mv $(fzf) $(find . -type d | fzf) }
      '';
      shellAliases = {
        v = "nvim";

        la = "eza -la";
        lg = "lazygit";
        ll = "eza -RTXF --git --icons";
        ls = "eza";

        bld = "home-manager switch";
        blds = "sudo nixos-rebuild switch";
      };
    };
  };

  programs.home-manager.enable = true;
}
