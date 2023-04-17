# Python User Script Directory
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# BUN Auto completions
[ -s "/home/vineel/.bun/_bun" ] && source "/home/vineel/.bun/_bun"

# BUN Install Directory
export BUN_INSTALL="$HOME/.bun"

# BUN Directory
if [ -d "$BUN_INSTALL/bin" ]; then
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

# Homebrew Directory
if test -e "brew"; then
    if test -e "$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"; then
        export PATH="$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"
    fi
fi

# VMN Directory
if [ -d "$HOME/Personal/VMN" ]; then
    export PATH="$HOME/Personal/VMN:$PATH"
fi

# Python User Script Directory for MacOS
if [ -d "$HOME/Library/Python/3.11/bin" ]; then
    export PATH="$HOME/Library/Python/3.11/bin:$PATH"
fi

