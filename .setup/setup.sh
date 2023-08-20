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
    curl https://raw.githubusercontent.com/vineelsai26/dotfiles/main/.setup/arch.sh | bash
elif [[ $OS == *"Ubuntu"* ]] || [[ $OS == *"Debian"* ]]; then
    curl https://raw.githubusercontent.com/vineelsai26/dotfiles/main/.setup/debian.sh | bash
elif [[ $OS == *"Fedora"* ]]; then
    curl https://raw.githubusercontent.com/vineelsai26/dotfiles/main/.setup/fedora.sh | bash
elif [[ $OS == "Darwin" ]]; then
    curl https://raw.githubusercontent.com/vineelsai26/dotfiles/main/.setup/dotfiles.sh | bash
fi
