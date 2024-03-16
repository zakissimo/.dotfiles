{ config, pkgs, ... }:

{
  home.username = "zak";
  home.homeDirectory = "/home/zak";

  home.stateVersion = "23.11";

  home.keyboard.enable = false;

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
      name = "rose-pine-dawn";
      package = pkgs.rose-pine-icon-theme;
    };
    font.name = "FiraCode Nerd Font Mono Medium";
  };

  qt = {
    enable = false;
    platformTheme = "gtk";
    style = {
      name = "Catppuccin-Mocha-Lavender";
      package = pkgs.catppuccin-kvantum.override { variant = "Mocha"; accent = "Lavender"; };
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 15;
  };

  services.dunst = {
    enable = true;
    configFile = "$HOME/.config/dunst/dunstrc";
    iconTheme = {
      name = "rose-pine";
      package = pkgs.rose-pine-icon-theme;
    };
    settings = {
      global = {
        browser = "${config.programs.firefox.package}/bin/firefox -new-tab";
        dmenu = "${pkgs.rofi}/bin/rofi -dmenu";
        monitor = 0;
        follow = "mouse";
        width = 350;
        origin = "top-right";
        offset = "41x41";
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 400;
        progress_bar_corner_radius = 5;
        indicate_hidden = "yes";
        shrink = "no";
        separator_height = 2;
        separator_color = "#11111b";
        padding = 15;
        horizontal_padding = 15;
        frame_width = 0;
        corner_radius = 10;
        sort = "yes";
        idle_threshold = 120;
        font = "FiraCode Nerd Font 10";
        line_height = 0;
        markup = "full";
        format = "<span weight='bold' font='12'>%s</span>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        word_wrap = "yes";
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        icon_position = "left";
        min_icon_size = 50;
        max_icon_size = 60;
        sticky_history = "yes";
        history_length = 20;
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        ignore_dbusclose = false;
        force_xwayland = false;
        force_xinerama = false;
        mouse_right_click = "close_all";
      };

      experimental.per_monitor_dpi = false;

      urgency_low = {
        background = "#181825";
        foreground = "#CDD6F4";
        highlight = "#CDD6F4";
        frame_color = "#181825";
        timeout = 5;
      };

      urgency_normal = {
        background = "#181825";
        foreground = "#CDD6F4";
        highlight = "#CDD6F4";
        frame_color = "#181825";
        timeout = 5;
      };

      urgency_critical = {
        background = "#181825";
        foreground = "#CDD6F4";
        frame_color = "#f38ba8";
        timeout = 1000;
      };
    };

  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    asusctl
    chromium
    dunst
    obs-studio
    playerctl
    sound-theme-freedesktop
    themechanger
  ];

  home.sessionVariables = with pkgs; {
    SOUND_THEME_DIR = "${sound-theme-freedesktop}";
    ROSE_PINE_ICON_DIR = "${rose-pine-icon-theme}";

    QT_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";

    ZSH_COMPDUMP = "$HOME/.cache/.zcompdump-$HOST";

    GOPATH = "$HOME/.config/go";
    PNPM_HOME = "$HOME/.config/pnpm";

    FZF_DEFAULT_OPTS = "--multi --layout=reverse --inline-info --height=80%";
    FZF_DEFAULT_COMMAND = "rg --files --hidden --ignore-file $XDG_CONFIG_HOME/.ignore 2>/dev/null";
  };

  home.sessionPath = [
    "$HOME/.bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
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
      sh "$HOME/.dotfiles/bin/link-bins"
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
      profileExtra = ''
        _add_path() { [ -d "$1" ] && export PATH="$PATH:$1" }

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
      };
    };
  };

  programs.home-manager.enable = true;
}
