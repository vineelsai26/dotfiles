alias apt='nala'
alias sudo='sudo '
alias ls='exa --icons'
alias ll='ls -alF'
alias l='ls -F'
alias vim='nvim'
alias rf='rm -rf'
alias df='df -h'
alias du='du -h'
alias htop='btop'

if ! command -v bat &> /dev/null; then
    if ! command -v batcat &> /dev/null; then
        alias cat='cat'
    else
        alias cat='batcat'
    fi
else
    alias cat='bat'
fi

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

if [[ $OS == *"Arch"* ]]; then
    alias up='sudo pacman -Syu'
elif [[ $OS == *"NixOS"* ]]; then
    alias up='sudo nixos-rebuild switch && sudo nix-channel --update && sudo nix-env -u "*"'
elif [[ $OS == *"Ubuntu"* ]] || [[ $OS == *"Debian"* ]]; then
    alias up='sudo apt update && apt upgrade'
elif [[ $OS == *"Fedora"* ]]; then
    alias up='sudo dnf update'
elif [[ $OS == "Darwin" ]]; then
    alias up='brew update && brew upgrade'
fi

# Using Git Bare repo for config management
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
