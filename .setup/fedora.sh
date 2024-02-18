#!/bin/bash

# Update and Upgrade
sudo dnf update -y

# Install basic packages
sudo dnf install -y git zsh curl wget gpg exa bat btop vim tmux python3 python3-pip python3-venv cmake make

# Setup dotfiles
curl -fsSL https://raw.githubusercontent.com/vineelsai26/dotfiles/main/.setup/dotfiles.sh | bash
