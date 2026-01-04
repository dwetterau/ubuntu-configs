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

# Create symlink for .vimrc
create_symlink "$SCRIPT_DIR/.vimrc" "$HOME_DIR/.vimrc" ".vimrc"

# Create symlink for mise.toml
create_symlink "$SCRIPT_DIR/mise.toml" "$HOME_DIR/mise.toml" "mise.toml"

# Create symlink for .zshrc
create_symlink "$SCRIPT_DIR/.zshrc" "$HOME_DIR/.zshrc" ".zshrc"

echo "Symlink setup complete!"
