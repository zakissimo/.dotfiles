#!/usr/bin/env bash

command -v brave >/dev/null 2>&1 || { echo >&2 "I require brave but it's not installed. Aborting."; exit 1; }

command -v megasync >/dev/null 2>&1 || { echo >&2 "I require megasync but it's not installed. Aborting."; exit 1; }

import(){
    [ ! -d "$HOME/MEGA/linuxrc/BraveSettings" ] && { echo >&2 "No saved settings found in MEGA! Aborting."; exit 1; }
    cp -r "$HOME/MEGA/linuxrc/BraveSettings/Default" "$HOME/.config/BraveSoftware/Brave-Browser/" && echo "Settings successfully synchronised!"
}

export(){
    [ ! -d "$HOME/MEGA/linuxrc/BraveSettings" ] && mkdir -p "$HOME/MEGA/linuxrc/BraveSettings"
    cp -r "$HOME/.config/BraveSoftware/Brave-Browser/Default" "$HOME/MEGA/linuxrc/BraveSettings/"
    echo "Settings successfully saved!"
}

op=("import" "export")
select choice in "${op[@]}"; do
    case $choice in
        import)
            import
            break
            ;;
        export)
            export
            break
            ;;
        quit)
            break
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
done
