# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];

  # Bootloader
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 3;
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  networking.hostName = "nix"; # Define your hostname.
  # networking.wireless.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  security = {
    polkit.enable = true;
    pam.services = {
      ags = { };
      swaylock = { };
    };
  };

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
      config.common.default = [ "*" ];
    };
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "zathura.desktop" ];
        "application/x-shellscript" = [ "neovide.desktop" ];
        "application/xhtml+xml+json" = [ "firefox.desktop" ];
        "image/*" = [ "imv.desktop" ];
        "inode/directory" = [ "pcmanfm.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "text/plain" = [ "neovide.desktop" ];
        "video/*" = [ "mpv.desktop" ];
        "audio/*" = [ "mpv.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/magnet" = [ "fragments.desktop" ];
      };
    };
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [
        amdvlk
        rocmPackages.clr.icd
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services = {
    blueman.enable = true;
    dbus.enable = true;
    gnome = {
      sushi.enable = true;
      gnome-keyring.enable = true;
    };
    gvfs.enable = true;
    power-profiles-daemon.enable = true;
    tumbler.enable = true;
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      xkb = {
        layout = "qwerty-fr, ara";
        options = "grp:alt_shift_toggle, ctrl:nocaps";
        extraLayouts.qwerty-fr = {
          description = "Qwerty with accents";
          languages = [ "us" "fr" ];
          symbolsFile = builtins.fetchurl {
            url = "https://gist.githubusercontent.com/zakissimo/bde1dc0b6e5fdce4f5a85f9cdfb76fbe/raw/0a512ef791ce4a945c5a2d3c4371747f0969c0a2/qwerty-fr";
          };
        };
      };
      libinput.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  programs = {
    dconf.enable = true;
    nix-ld.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    zsh = {
      enable = true;
    };

  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      qt5 = {
        enable = true;
        platformTheme = "qt5ct";
        style = {
          name = "catppuccin-kvantum";
          package = pkgs.catppuccin-kvantum;
        };
      };
    };
  };

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.zak = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "zak";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [ ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts =
        [
          "CascadiaCode"
          "FiraCode"
          "FiraMono"
          "JetBrainsMono"
          "Noto"
          "UbuntuMono"
        ];
    })
  ];

  environment.systemPackages = with pkgs; [
    # Dev
    (hiPrio clang-tools.override {
      llvmPackages = llvmPackages_16;
      enableLibcxx = false;
    })
    llvmPackages_16.libstdcxxClang
    (lib.lowPrio gcc)

    binutils
    cmake
    delta
    gdb
    git
    gnumake
    lazygit
    meson
    neovide
    neovim
    ninja
    nodejs
    openssl
    pkg-config
    python3
    qt5.qtwayland
    qt6.qtwayland
    rustup
    valgrind

    # Terminal Applications
    bat
    brillo
    btop
    curl
    desktop-file-utils
    eza
    fd
    feh
    ffmpegthumbnailer
    fuseiso
    fzf
    imagemagick
    imv
    inotify-tools
    man-pages
    man-pages-posix
    mediainfo
    mpc-cli
    mpv
    networkmanagerapplet
    odt2txt
    p7zip
    pamixer
    power-profiles-daemon
    psmisc
    ripgrep
    stow
    unrar
    unzip
    vagrant
    wget
    yt-dlp
    zathura

    # Graphical Applications
    firefox-wayland
    flameshot
    fragments
    gparted
    loupe
    pcmanfm
    peek
    pavucontrol
    rofi-wayland
    via
    wezterm

    # Theme
    adwaita-qt
    adwaita-qt6
    catppuccin-kvantum
    themechanger

    # Compositor utility
    grim
    hyprland-protocols
    hyprpaper
    playerctl
    slurp
    swaybg
    swayidle
    swaylock-effects
    waybar
    wl-clipboard
    wlogout
    wlr-randr
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    xorg.xhost

    home-manager
  ];

  environment.variables = rec {
    SUDO_EDITOR = "nvim";
    VISUAL = "neovide";
    EDITOR = "nvim";
    TERMINAL = "wezterm";
    BROWSER = "firefox";

    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";

    QT_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    XCURSOR_SIZE = "22";
    WLR_NO_HARDWARE_CURSORS = "1";

    # NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";

    GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    WLR_RENDERER = "vulkan";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";

    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";

    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
