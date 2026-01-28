#!/bin/bash

# ~/.config/dotfiles/install.sh

set -e

echo "Starting installation..."

# Install Homebrew if not found
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add brew to path for the current session
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Install dependencies from Brewfile
BREWFILE="$HOME/.config/dotfiles/Brewfile"
if [ -f "$BREWFILE" ]; then
    echo "Installing packages from $BREWFILE..."
    brew bundle --file="$BREWFILE"
else
    echo "Brewfile not found at $BREWFILE"
fi

# Function to interact with dotfiles repo
function dot {
   git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

mkdir -p "$HOME/.config/oh-my-posh" 

# Ensure we don't overwrite existing files without backup
echo "Checking out dotfiles..."
if ! dot checkout; then
    echo "Backing up pre-existing dot files..."
    mkdir -p "$HOME/.dotfiles-backup"
    dot checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} mv "$HOME/{}" "$HOME/.dotfiles-backup/{}"
    dot checkout
fi

dot config --local status.showUntrackedFiles no

echo "Installation complete! Please restart your shell."
