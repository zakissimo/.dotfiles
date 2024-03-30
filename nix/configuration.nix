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

  networking.hostName = "nix";
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
        "application/pdf" = [ "mupdf.desktop" ];
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
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    keyboard.qmk.enable = true;
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
    openrazer = {
      enable = true;
      users = [ "zak" ];
    };
    pulseaudio.enable = false;
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
    };
  };

  sound.enable = true;
  security.rtkit.enable = true;

  users.users.zak = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "zak";
    extraGroups = [ "networkmanager" "wheel" "video" "plugdev" "docker" "audio" ];
    packages = with pkgs; [ ];
  };

  users.groups.plugdev = {
    members = [ "zak" ];
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
    #Dev
    binutils
    clang
    clang-tools
    cmake
    delta
    extra-cmake-modules
    gcc
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
    qt5Full
    qtcreator
    rustup
    valgrind

    # Terminal Applications
    ansifilter
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
    jq
    man-pages
    man-pages-posix
    mediainfo
    mpc-cli
    mpv
    mupdf
    networkmanagerapplet
    odt2txt
    openrazer-daemon
    p7zip
    pamixer
    power-profiles-daemon
    psmisc
    ripgrep
    stow
    unrar
    unzip
    usbutils
    vagrant
    viu
    wget
    yt-dlp

    # Graphical Applications
    firefox-wayland
    flameshot
    fragments
    gparted
    loupe
    pcmanfm
    peek
    pavucontrol
    polychromatic
    razergenie
    rofi-wayland
    via
    wezterm
    xarchiver

    # Compositor utility
    greetd.greetd
    greetd.tuigreet
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

    WLR_NO_HARDWARE_CURSORS = "1";

    NIXOS_OZONE_WL = "1";
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

  services = {
    blueman.enable = true;
    dbus.enable = true;
    gnome = {
      sushi.enable = true;
      gnome-keyring.enable = true;
    };
    gvfs.enable = true;
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "zak";
        };
        default_session = initial_session;
      };
    };
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    power-profiles-daemon.enable = true;
    printing.enable = true;
    tumbler.enable = true;
    udev.packages = [ pkgs.via ];
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
    };
  };

  system.stateVersion = "23.11";
}
