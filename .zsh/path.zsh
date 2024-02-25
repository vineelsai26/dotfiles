export SHELL=/bin/zsh

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

# 1Password
if [ -f "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" ]; then
    export PATH="/Applications/1Password.app/Contents/MacOS:$PATH"
elif [ -f "/opt/1Password/op-ssh-sign" ]; then
    export PATH="/opt/1Password:$PATH"
fi

if test -e "ng"; then
  source <(ng completion script)
fi

# VMN Directory
if [ -d "$HOME/.vmn" ]; then
    export PATH="$HOME/.vmn:$PATH"
fi

# Python User Script Directory for MacOS
if [ -d "$HOME/Library/Python/3.11/bin" ]; then
    export PATH="$HOME/Library/Python/3.11/bin:$PATH"
fi

# K3s
if [ -f "$HOME/.kube/config" ]; then
    export KUBECONFIG="$HOME/.kube/config"
fi

# iTerm2 Shell Integration
if [[ $(uname -s) == "Darwin" ]]; then
    test -e "${HOME}/.zsh/.iterm2_shell_integration.zsh" && source "${HOME}/.zsh/.iterm2_shell_integration.zsh"
fi

# pnpm
if [[ $(uname -s) == "Darwin" ]]; then
    export PNPM_HOME="/Users/vineel/Library/pnpm"
    case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
fi
# pnpm end
