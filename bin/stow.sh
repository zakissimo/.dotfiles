#!/usr/bin/env bash

set -u

STOW_DIR="$HOME/.dotfiles/packages"
DRY_RUN=0

if ! command -v stow >/dev/null 2>&1; then
    echo "Error: 'stow' is not installed" >&2
    exit 1
fi

die() {
    echo "Error: $*" >&2
    exit 1
}

require_pkg_dir() {
    [[ -d "$STOW_DIR/$1" ]] || die "stow package '$1' not found at $STOW_DIR/$1"
}

# Build the stow flag list, injecting --simulate under dry-run.
stow_flags() {
    local flags=(-v -t "$HOME")
    [[ $DRY_RUN -eq 1 ]] && flags+=(-n)
    printf '%s\n' "${flags[@]}"
}

# Pre-delete real files in $HOME that would conflict with the package's
# symlinks, and pre-create target directories so stow doesn't error.
cloneAndStow() {
    local pkg="$1"
    require_pkg_dir "$pkg"

    local real
    while IFS= read -r -d '' path; do
        real="$HOME/${path#"$STOW_DIR/$pkg/"}"
        if [[ -f "$real" ]]; then
            if [[ -L "$real" ]]; then
                # Stale symlink from a previous stow — remove silently.
                [[ $DRY_RUN -eq 0 ]] && rm "$real"
            else
                # Real file — warn, potential data loss.
                if [[ $DRY_RUN -eq 1 ]]; then
                    echo "[dry-run] would remove conflicting file: $real"
                else
                    echo "⚠ removing conflicting file: $real"
                    rm "$real"
                fi
            fi
        fi
    done < <(find "$STOW_DIR/$pkg" -type f -print0)

    while IFS= read -r -d '' path; do
        real="$HOME/${path#"$STOW_DIR/$pkg/"}"
        if [[ ! -d "$real" ]]; then
            if [[ $DRY_RUN -eq 1 ]]; then
                echo "[dry-run] would create directory: $real"
            else
                mkdir -p "$real"
            fi
        fi
    done < <(find "$STOW_DIR/$pkg" -mindepth 1 -type d -print0)

    local flags
    mapfile -t flags < <(stow_flags)
    (cd "$STOW_DIR" && stow "${flags[@]}" -S "$pkg") \
        || echo "Failed stowing $pkg" >&2
}

cloneAndUnstow() {
    local pkg="$1"
    require_pkg_dir "$pkg"

    local flags
    mapfile -t flags < <(stow_flags)
    (cd "$STOW_DIR" && stow "${flags[@]}" -D "$pkg") \
        || echo "Failed unstowing $pkg" >&2
}

# Adopt existing files from $HOME into the package.
# Without path args: walk ~/.config/<pkg>/ (original behavior).
# With path args: each is $HOME-relative (e.g. ".zshenv", ".config/foo/bar").
cloneAndAdopt() {
    local pkg="$1"
    shift
    require_pkg_dir "$pkg"

    local paths=("$@")
    if [[ ${#paths[@]} -eq 0 ]]; then
        local src="$HOME/.config/$pkg"
        [[ -d "$src" ]] || die "no paths given and default source $src does not exist"
        while IFS= read -r -d '' path; do
            paths+=("${path#"$HOME/"}")
        done < <(find "$src" -type f -print0)
        [[ ${#paths[@]} -gt 0 ]] || die "no files found under $src"
    fi

    local placeholder placeholder_dir
    for rel in "${paths[@]}"; do
        placeholder="$STOW_DIR/$pkg/$rel"
        placeholder_dir="$(dirname "$placeholder")"
        if [[ $DRY_RUN -eq 1 ]]; then
            echo "[dry-run] would touch placeholder: $placeholder"
        else
            mkdir -p "$placeholder_dir"
            [[ -e "$placeholder" ]] || touch "$placeholder"
        fi
    done

    local flags
    mapfile -t flags < <(stow_flags)
    (cd "$STOW_DIR" && stow "${flags[@]}" --adopt -S "$pkg") \
        || echo "Failed adopting $pkg" >&2
}

usage() {
    cat <<EOF
Usage:
  $0 stow [pkg]             Stow all packages or a specific one
  $0 unstow <pkg>           Unstow a package (remove its symlinks)
  $0 adopt <pkg> [path...]  Pull existing files from \$HOME into the package.
                            Default source: ~/.config/<pkg>/**
                            Explicit paths are \$HOME-relative (e.g. .zshenv)

Flags:
  -n, --dry-run             Preview without making changes
  -h, --help                Show this help
EOF
}

args=()
for arg in "$@"; do
    case "$arg" in
        -n|--dry-run) DRY_RUN=1 ;;
        -h|--help)    usage; exit 0 ;;
        *)            args+=("$arg") ;;
    esac
done
set -- "${args[@]}"

command="${1:-}"
[[ $# -gt 0 ]] && shift

case "$command" in
stow)
    if [[ $# -gt 0 ]]; then
        cloneAndStow "$1"
    else
        while IFS= read -r -d '' app; do
            cloneAndStow "${app##*/}"
        done < <(find "$STOW_DIR" -mindepth 1 -maxdepth 1 -type d -print0)
    fi
    ;;
unstow)
    [[ $# -gt 0 ]] || die "unstow requires a package name"
    cloneAndUnstow "$1"
    ;;
adopt)
    [[ $# -gt 0 ]] || die "adopt requires a package name"
    cloneAndAdopt "$@"
    ;;
*)
    usage
    exit 1
    ;;
esac
