#!/bin/bash

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
fi

current=$pwd
git clone --bare https://github.com/vineelsai26/dotfiles $HOME/.cfg
git --git-dir=$HOME/.cfg/ --work-tree=$HOME stash
git --git-dir=$HOME/.cfg/ --work-tree=$HOME reset --hard
git --git-dir=$HOME/.cfg/ --work-tree=$HOME submodule init
git --git-dir=$HOME/.cfg/ --work-tree=$HOME submodule update
cd $current

if ! command -v starship &> /dev/null; then
    if [[ $OS == *"Arch"* ]]; then
        sudo pacman -Syu starship
    elif [[ $OS == *"Ubuntu"* ]] || [[ $OS == *"Debian"* ]]; then
        sudo apt install -y starship
    elif [[ $OS == *"Fedora"* ]]; then
        sudo dnf install -y starship
    elif [[ $OS == "Darwin" ]]; then
        brew install starship
    fi
fi

if command -v zsh &> /dev/null; then
    zsh
fi

if [[ -f "${HOME}/.bash_history" ]]; then
    cat $HOME/.bash_history >>$HOME/.zsh_history
fi
