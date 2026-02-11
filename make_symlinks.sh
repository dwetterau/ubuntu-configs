#!/bin/bash

# Script to create symlinks for configuration files in the home directory
# This allows configuration files to live in this repo but be used from ~

set -e  # Exit on error

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

# Function to create a symlink from repo file to home location
create_symlink() {
    local REPO_FILE="$1"
    local HOME_FILE="$2"
    local FILE_NAME="$3"
    
    if [ ! -f "$REPO_FILE" ]; then
        echo "Error: $REPO_FILE does not exist in the repo"
        exit 1
    fi
    
    # Check if target already exists
    if [ -e "$HOME_FILE" ]; then
        # Check if it's already a symlink to our file
        if [ -L "$HOME_FILE" ] && [ "$(readlink -f "$HOME_FILE")" = "$(readlink -f "$REPO_FILE")" ]; then
            echo "$FILE_NAME is already symlinked correctly"
        else
            # Backup existing file
            BACKUP="$HOME_FILE.backup.$(date +%Y%m%d_%H%M%S)"
            echo "Backing up existing $FILE_NAME to $BACKUP"
            mv "$HOME_FILE" "$BACKUP"
            ln -sf "$REPO_FILE" "$HOME_FILE"
            echo "Created symlink: $HOME_FILE -> $REPO_FILE"
        fi
    else
        # Create the symlink
        ln -sf "$REPO_FILE" "$HOME_FILE"
        echo "Created symlink: $HOME_FILE -> $REPO_FILE"
    fi
}

# Function to create a symlink for a directory
create_dir_symlink() {
    local REPO_DIR="$1"
    local TARGET_DIR="$2"
    local DIR_NAME="$3"
    
    if [ ! -d "$REPO_DIR" ]; then
        echo "Error: $REPO_DIR does not exist in the repo"
        exit 1
    fi
    
    # Ensure parent directory exists
    mkdir -p "$(dirname "$TARGET_DIR")"
    
    if [ -e "$TARGET_DIR" ]; then
        if [ -L "$TARGET_DIR" ] && [ "$(readlink -f "$TARGET_DIR")" = "$(readlink -f "$REPO_DIR")" ]; then
            echo "$DIR_NAME is already symlinked correctly"
        else
            BACKUP="$TARGET_DIR.backup.$(date +%Y%m%d_%H%M%S)"
            echo "Backing up existing $DIR_NAME to $BACKUP"
            mv "$TARGET_DIR" "$BACKUP"
            ln -sf "$REPO_DIR" "$TARGET_DIR"
            echo "Created symlink: $TARGET_DIR -> $REPO_DIR"
        fi
    else
        ln -sf "$REPO_DIR" "$TARGET_DIR"
        echo "Created symlink: $TARGET_DIR -> $REPO_DIR"
    fi
}

# Create symlink for .vimrc
create_symlink "$SCRIPT_DIR/.vimrc" "$HOME_DIR/.vimrc" ".vimrc"

# Create symlink for mise.toml
create_symlink "$SCRIPT_DIR/mise.toml" "$HOME_DIR/mise.toml" "mise.toml"

# Create symlink for .zshrc
create_symlink "$SCRIPT_DIR/.zshrc" "$HOME_DIR/.zshrc" ".zshrc"

# Create symlink for GNOME extension: no-shutdown-delay
GNOME_EXT_DIR="$HOME_DIR/.local/share/gnome-shell/extensions"
create_dir_symlink "$SCRIPT_DIR/gnome-extensions/no-shutdown-delay@local" "$GNOME_EXT_DIR/no-shutdown-delay@local" "no-shutdown-delay@local"

echo "Symlink setup complete!"
