#!/bin/bash

# Update and Upgrade
sudo pacman -Syu --noconfirm

# Install basic packages
sudo pacman -S --noconfirm git zsh curl wget gpg exa bat btop vim tmux python3 python3-pip python3-venv cmake make

# Setup dotfiles
curl -fsSL https://raw.githubusercontent.com/vineelsai26/dotfiles/main/.setup/dotfiles.sh | bash

# Setup My Repo
echo "
[vineelsai-arch-repo]
Server = https://repo.vineelsai.com/linux/arch/$arch" | sudo tee -a /etc/pacman.conf > /dev/null

# Setup My Repo Keys
sudo pacman-key --lsign-key 4431E64723B4ADDE

# Install Packages from my repo
sudo pacman -Syu --noconfirm vmn
