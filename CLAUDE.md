# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal Linux dotfiles for an Arch/CachyOS + Wayland setup. Configs are organized into GNU Stow packages under `packages/` and deployed into `$HOME` as symlinks by a thin wrapper script. There is no build system — edits to files under `packages/<pkg>/` show up live because `$HOME/.config/...` is already a symlink into the repo.

Compositor is **niri** (KDL). Desktop shell is **DankMaterialShell** (Quickshell-based).

## Install / deploy commands

```bash
bin/stow.sh stow                          # stow every package under packages/
bin/stow.sh stow <pkg>                    # stow just packages/<pkg>
bin/stow.sh unstow <pkg>                  # remove packages/<pkg>'s symlinks from $HOME
bin/stow.sh adopt <pkg>                   # pull ~/.config/<pkg>/** files INTO the repo
bin/stow.sh adopt home .zshenv .gitconfig # adopt explicit $HOME-relative paths
bin/link-bins                             # symlink bin/* into ~/.local/bin/
```

Pass `-n` / `--dry-run` to any command to preview without modifying anything. The script will also error out cleanly if `stow` is missing or the named package directory doesn't exist.

`stow.sh` is not plain `stow` — before invoking `stow`, it **deletes any real files** at destination paths that conflict with the package, and pre-creates any missing target directories. Real-file deletions print a `⚠ removing conflicting file:` warning; stale symlinks from a previous stow are removed silently. Running `bin/stow.sh stow <pkg>` can therefore replace a real file in `$HOME` with a symlink into the repo — the warning is your only signal, so use `--dry-run` first if unsure.

`adopt` is the reverse: it creates placeholder files in the repo, then runs `stow --adopt` to move the real files in and leave symlinks behind. Default source is `~/.config/<pkg>/**`; pass explicit `$HOME`-relative paths to adopt files outside `~/.config/` (e.g. into the `home/` package).

## Repository layout

- `packages/<pkg>/` — each subdir is a Stow package. File paths under it mirror where they land in `$HOME` (e.g. `packages/home/.config/zsh/.zshrc` → `~/.config/zsh/.zshrc`).
  - `home/` — shell/top-level: `.zshenv`, `.gitconfig`, `.config/zsh/` (zimfw), `.local/share/rose-pine`
  - `niri/` — the compositor. `config.kdl` includes `env.kdl`, `input.kdl`, `layout.kdl`, `binds.kdl`
  - `DankMaterialShell/` — DMS settings, themes, and custom QML plugins (`nyTime`, `timeForSalat`)
  - `kitty/`, `rofi/`, `starship/`, `zellij/`, `Kvantum/` (DMS + matugen owns all GTK and Qt theming on disk — intentionally not tracked)
- `bin/` — personal utility scripts (bash/zsh) symlinked onto PATH via `link-bins`: `change-vol`, `kbd_light`, `mon_light`, `tmpclip`, `vimv`.
- `wine/` — wine registry themes + `set_wine_theme.sh <file.reg>` applies via `wine regedit`.
- `png/` — wallpaper assets.

## Files niri/DMS reference but that are NOT in this repo

Gitignored because they're machine-specific and written by tools at runtime. Do not commit them; do not be surprised when `include` lines resolve to missing files on a fresh clone:

- `packages/niri/.config/niri/dms/cursor.kdl`, `dms/outputs.kdl` — written by DankMaterialShell
- `~/.config/niri/host.kdl` — per-host niri overrides (extra `input {}` / `binds {}` blocks that merge with the committed base). Lives outside the stow source; niri refuses to load if missing, so `touch ~/.config/niri/host.kdl` after a fresh clone even if you have no overrides.
- `packages/DankMaterialShell/.config/DankMaterialShell/settings.json` — DMS user settings
- `packages/DankMaterialShell/.config/DankMaterialShell/plugins/*/plugin_settings.json` and any `*plugin_settings.json` — per-host plugin state

See `.gitignore` for the full list.

## Zsh setup

`ZDOTDIR=$XDG_CONFIG_HOME/zsh`, so `.zshrc`/`.zimrc`/`.zprofile` live under `packages/home/.config/zsh/`. `.zshenv` (top-level) sets XDG vars, language toolchain homes (`GOPATH`, `PNPM_HOME`, `BUN_INSTALL`, `FNM_PATH`), and `EDITOR=nvim`.

`.zshrc` uses **zimfw** — it bootstraps itself from GitHub on first run if `$ZIM_HOME/zimfw.zsh` is missing. Modules are declared in `.zimrc`. A `zellij_tab_name_update` hook is wired into `chpwd`/`precmd` to rename the current Zellij tab based on the git repo/path. `zel` and `zell` helpers attach to named Zellij sessions and toggle an `IN_ZELLIJ` terminal user-var that Kitty reads to swap keybinds (see `kitty.conf` `--when-focus-on var:IN_ZELLIJ`).

## DankMaterialShell plugins (QML)

Custom plugins under `packages/DankMaterialShell/.config/DankMaterialShell/plugins/`:

- `timeForSalat/` — Islamic prayer times via an external `time_for_salat <slug>` CLI
- `nyTime/` — New York clock widget

Each plugin has `plugin.json` declaring `component`, `settings`, and `permissions` (e.g. `settings_read`, `settings_write`). The widget QML imports from `qs.Common`, `qs.Services`, `qs.Widgets`, `qs.Modules.Plugins` — those come from the DMS runtime, not this repo. User state goes into a `plugin_settings.json` sibling file (gitignored).

## Environment targeting (important when adding scripts)

Scripts in `bin/` assume a specific stack:

- **Audio**: `pamixer`, `pw-play` (PipeWire)
- **Notifications**: `notify-send` / `dunstify`
- **Backlight**: `brillo` (screen), `asusctl` (ROG G15 keyboard — laptop-specific)
- **Wayland**: `wl-clipboard`/`wclip`, `dms` (DMS IPC)
- **Menus**: `rofi`, `tofi`, `fzf`
- **Misc**: `jq`

If you're editing these scripts, don't introduce new hard dependencies casually — check that the tool is installable via pacman/AUR first. `kbd_light` is ROG-laptop-only (`asusctl`) and won't work on desktops.

## Keybind conventions

niri uses `Super` as the mod. Many actions delegate to DMS via `dms ipc call ...` (lock, spotlight, screenshot). Prefer calling into DMS rather than shelling out to a separate tool — keeps behavior consistent and avoids duplicating state.
