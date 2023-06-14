#!/usr/bin/env bash

set -ex

echo "Define root password: "
passwd

command -v apt >/dev/null 2>&1 && apt update -y && INSTALL="apt install -y --no-install-recommends"
command -v apk >/dev/null 2>&1 && apk update -y && INSTALL="apk add -y"
command -v pacman >/dev/null 2>&1 && pacman update && pacman upgrade && INSTALL="pacman -S --noconfirm"

apps=(curl sudo)

function install {
    for app in "$@"; do
    which "$app" \
        || $INSTALL "$app"
    done
}

install "${apps[@]}"

echo "Enter your username: "
read -r USER
useradd -m -G sudo -s /bin/bash "$USER"

cat <<'EOF'> /tmp/last.sh
#!/usr/bin/env bash

function install {
    for app in $@; do
    which $app \
        || $INSTALL $app
    done
}
sh <(curl -L https://nixos.org/nix/install) --no-daemon

nixpkgs=(
    nixpkgs.curl
    nixpkgs.delta
    nixpkgs.exa
    nixpkgs.fuse
    nixpkgs.fzf
    nixpkgs.git
    nixpkgs.lazygit
    nixpkgs.lua
    nixpkgs.nodejs
    nixpkgs.npm
    nixpkgs.nvim
    nixpkgs.ripgrep
    nixpkgs.ssh
    nixpkgs.stow
    nixpkgs.tmux
    nixpkgs.zsh
)

INSTALL="nix-env -iA"

install ${nixpkgs[@]}

EOF

chmod +x /tmp/last.sh
chown "$USER":"$USER" /tmp/last.sh

# sudo chsh -s "$(which zsh)" "$USER"

su - "$USER" -c "$(/tmp/last.sh)"
