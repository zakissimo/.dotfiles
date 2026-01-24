#!/usr/bin/env bash

# Check argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 THEME"
    exit 1
fi

THEME="$1"

run_wine_regedit() {
    local wine_cmd="$1"
    if command -v "$wine_cmd" >/dev/null 2>&1; then
        "$wine_cmd" regedit "$THEME"
    else
        echo "Warning: $wine_cmd not found, skipping."
    fi
}

# Try both wine locations
run_wine_regedit "wine"
# run_wine_regedit "/opt/wine-cachyos/bin/wine"
