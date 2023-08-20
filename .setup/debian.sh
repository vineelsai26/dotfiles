#!/bin/bash

# Update and Upgrade
sudo apt update && sudo apt upgrade -y

# Install basic packages
sudo apt install -y git zsh curl wget gpg nala exa bat btop vim tmux python3 python3-pip python3-venv python3-dev build-essential cmake apt-transport-https

# Setup dotfiles
curl -fsSL https://raw.githubusercontent.com/vineelsai26/dotfiles/main/.setup/dotfiles.sh | bash

# Setup My Repo
curl -fsSL https://repo.vineelsai.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/vineelsai.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/vineelsai.gpg] https://repo.vineelsai.com/linux/debian stable main" | sudo tee /etc/apt/sources.list.d/vineelsai.list > /dev/null

# Install Packages from my repo
sudo apt update
sudo apt install -y vmn neovim

# Setup vscode repo
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# Install vscode
sudo apt update
sudo apt install -y code

# Setup Brave repo
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# Install Brave
sudo apt update
sudo apt install -y brave-browser

# Setup Docker repo
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
