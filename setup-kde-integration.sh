#!/usr/bin/env bash

# Setup script for LibreWolf KDE Plasma & Qt Integration on Artix / Arch Linux

set -e

echo "=== LibreWolf KDE Plasma Integration Setup ==="

# Step 1: Check and Install Required Packages on Artix/Arch Linux
if command -v pacman >/dev/null 2>&1; then
    echo "[1/3] Checking required packages..."
    PACKAGES=("appmenu-gtk-module" "xdg-desktop-portal" "xdg-desktop-portal-kde" "plasma-browser-integration")
    MISSING_PACKAGES=()

    for pkg in "${PACKAGES[@]}"; do
        if ! pacman -Qq "$pkg" >/dev/null 2>&1; then
            MISSING_PACKAGES+=("$pkg")
        fi
    done

    if [ ${#MISSING_PACKAGES[@]} -ne 0 ]; then
        echo "The following required packages are missing: ${MISSING_PACKAGES[*]}"
        echo "Installing missing packages with pacman..."
        sudo pacman -S --needed --noconfirm "${MISSING_PACKAGES[@]}"
    else
        echo "All required packages are installed."
    fi
else
    echo "[1/3] non-pacman system detected. Please ensure appmenu-gtk-module and xdg-desktop-portal-kde are installed."
fi

# Step 2: Configure GTK Environment Variable for Global Menu Export
echo "[2/3] Setting up GTK environment configuration for Global Menu..."
ENV_DIR="$HOME/.config/environment.d"
ENV_FILE="$ENV_DIR/10-gtk-modules.conf"

mkdir -p "$ENV_DIR"

if [ -f "$ENV_FILE" ] && grep -q "GTK_MODULES.*appmenu-gtk-module" "$ENV_FILE"; then
    echo "Environment variable GTK_MODULES already present in $ENV_FILE."
else
    echo "GTK_MODULES=appmenu-gtk-module" >> "$ENV_FILE"
    echo "Added GTK_MODULES=appmenu-gtk-module to $ENV_FILE"
fi

# Step 3: Copy user.js to LibreWolf Profiles
echo "[3/3] Deploying KDE integration preferences (user.js) to LibreWolf profile(s)..."
LIBREWOLF_DIR="$HOME/.librewolf"

if [ -d "$LIBREWOLF_DIR" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    USER_JS_SOURCE="$SCRIPT_DIR/user.js"

    if [ -f "$USER_JS_SOURCE" ]; then
        FOUND_PROFILE=0
        for profile in "$LIBREWOLF_DIR"/*/; do
            if [ -d "$profile" ]; then
                cp "$USER_JS_SOURCE" "$profile/user.js"
                echo "Applied user.js to: $(basename "$profile")"
                FOUND_PROFILE=1
            fi
        done
        if [ $FOUND_PROFILE -eq 0 ]; then
            echo "No profile directories found in $LIBREWOLF_DIR."
        fi
    else
        echo "Error: user.js source file not found at $USER_JS_SOURCE"
    fi
else
    echo "LibreWolf config directory ($LIBREWOLF_DIR) not found. Launch LibreWolf once to create your profile, then re-run this script."
fi

echo "=== Setup Complete ==="
echo "Note: Please log out and log back in (or restart your session) for Global Menu environment variables to take full effect."
