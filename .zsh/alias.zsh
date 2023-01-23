alias apt='nala'
alias sudo='sudo '
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vim='nvim'
alias rf='rm -rf'

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

if [[ $OS == *"Fedora"* ]]; then
    alias up='sudo dnf update'
elif [[ $OS == *"Ubuntu"* ]]; then
    alias up='sudo apt update && apt upgrade'
elif [[ $OS == *"Debian"* ]]; then
    alias up='sudo apt update && apt upgrade'
fi
