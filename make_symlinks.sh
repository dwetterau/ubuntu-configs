#!/bin/bash

# Script to create symlinks for configuration files in the home directory
# This allows configuration files to live in this repo but be used from ~

set -e  # Exit on error

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

# Create symlink for .vimrc
VIMRC_REPO="$SCRIPT_DIR/.vimrc"
VIMRC_HOME="$HOME_DIR/.vimrc"

if [ ! -f "$VIMRC_REPO" ]; then
    echo "Error: $VIMRC_REPO does not exist in the repo"
    exit 1
fi

# Check if ~/.vimrc already exists
if [ -e "$VIMRC_HOME" ]; then
    # Check if it's already a symlink to our file
    if [ -L "$VIMRC_HOME" ] && [ "$(readlink -f "$VIMRC_HOME")" = "$(readlink -f "$VIMRC_REPO")" ]; then
        echo ".vimrc is already symlinked correctly"
    else
        # Backup existing file
        BACKUP="$VIMRC_HOME.backup.$(date +%Y%m%d_%H%M%S)"
        echo "Backing up existing .vimrc to $BACKUP"
        mv "$VIMRC_HOME" "$BACKUP"
        ln -sf "$VIMRC_REPO" "$VIMRC_HOME"
        echo "Created symlink: $VIMRC_HOME -> $VIMRC_REPO"
    fi
else
    # Create the symlink
    ln -sf "$VIMRC_REPO" "$VIMRC_HOME"
    echo "Created symlink: $VIMRC_HOME -> $VIMRC_REPO"
fi

echo "Symlink setup complete!"
