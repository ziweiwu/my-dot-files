#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Files to symlink: source (relative to repo) -> target
declare -a LINKS=(
    "tmux.conf:$HOME/.tmux.conf"
    "vimrc:$HOME/.vim/vimrc"
    "bashrc:$HOME/.bashrc"
    ".zshrc:$HOME/.zshrc"
)

# Directories to symlink: source (relative to repo) -> target
declare -a DIR_LINKS=(
    "tmux-scripts:$HOME/.tmux/scripts"
)

backed_up=false

backup_if_exists() {
    local target="$1"
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ "$backed_up" = false ]; then
            echo "Creating backup directory: $BACKUP_DIR"
            mkdir -p "$BACKUP_DIR"
            backed_up=true
        fi
        local backup_path="$BACKUP_DIR/$(basename "$target")"
        echo "  Backing up: $target -> $backup_path"
        mv "$target" "$backup_path"
    fi
}

create_symlink() {
    local source="$1"
    local target="$2"

    # Ensure parent directory exists
    mkdir -p "$(dirname "$target")"

    backup_if_exists "$target"

    echo "  Linking: $target -> $source"
    ln -s "$source" "$target"
}

echo "=== Dotfiles Installer ==="
echo "Source: $DOTFILES_DIR"
echo ""

# Symlink individual files
echo "Linking config files..."
for entry in "${LINKS[@]}"; do
    source="${entry%%:*}"
    target="${entry##*:}"
    create_symlink "$DOTFILES_DIR/$source" "$target"
done

# Symlink script directories
echo "Linking script directories..."
for entry in "${DIR_LINKS[@]}"; do
    source="${entry%%:*}"
    target="${entry##*:}"
    create_symlink "$DOTFILES_DIR/$source" "$target"
done

# Install TPM (Tmux Plugin Manager) if not present
echo "Checking Tmux Plugin Manager..."
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    echo "  Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo "  TPM installed. Open tmux and press prefix + I to install plugins."
else
    echo "  TPM already installed."
fi

# Create Vim directories
echo "Setting up Vim directories..."
mkdir -p "$HOME/.vim/swapfiles"
mkdir -p "$HOME/.vim/undodir"
echo "  Created ~/.vim/swapfiles and ~/.vim/undodir"

# Copy .zshrc.local.example if no local config exists
echo "Checking local config..."
if [ ! -f "$HOME/.zshrc.local" ]; then
    cp "$DOTFILES_DIR/.zshrc.local.example" "$HOME/.zshrc.local"
    echo "  Created ~/.zshrc.local from example — edit it for this machine."
else
    echo "  ~/.zshrc.local already exists, skipping."
fi

# Install Zap plugin manager if not present
echo "Checking Zap plugin manager..."
ZAP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zap"
if [ ! -d "$ZAP_DIR" ]; then
    echo "  Installing Zap..."
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
    echo "  Zap installed."
else
    echo "  Zap already installed."
fi

echo ""
echo "=== Done ==="
if [ "$backed_up" = true ]; then
    echo "Backups saved to: $BACKUP_DIR"
fi
echo ""
echo "Next steps:"
echo "  1. Edit ~/.zshrc.local for machine-specific settings (Java, Conda, work aliases, etc.)"
echo "  2. Restart your shell or run: source ~/.zshrc"
echo "  3. Open tmux and press prefix + I to install tmux plugins"
echo "  4. Open vim and run :PlugInstall to install vim plugins"
