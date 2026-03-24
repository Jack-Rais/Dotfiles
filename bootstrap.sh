#!/usr/bin/env bash

# Exit immediately if a command fails
set -e

echo "[INFO] Starting dotfiles bootstrap"
DOT_PATH="$(cd "$(dirname "$0")" && pwd)"


echo "[INFO] Script directory: $SCRIPT_DIR"

# Update system packages
echo "[INFO] Updating system packages"
sudo pacman -Syu --noconfirm

echo "[INFO] Installing base dependencies (git, base-devel, rustup)"
sudo pacman -S --needed --noconfirm git base-devel rustup

echo "[INFO] Building jackset"
cd "$DOT_PATH/jackset"
cargo build --release

echo "[INFO] Installing jackset to /usr/local/bin"
sudo cp "./target/release/jackset" "/usr/local/bin/jackset"

echo "[INFO] Building jackwall"
cd "$DOT_PATH/jackwall"
cargo build --release

echo "[INFO] Installing jackwall to /usr/local/bin"
sudo cp "./target/release/jackwall" "/usr/local/bin/jackwall"

echo "[INFO] Running jackset setup"
jackset setup --pacman --aur --display --services

echo "[INFO] Linking dotfiles"
jackset link --source "$DOT_PATH" --mode "link" --reload

echo "[INFO] Bootstrap completed successfully"
