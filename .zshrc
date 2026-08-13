export OH_MY_ZSH="$HOME/.zsh/ohmyzsh"

plugins=(git gh pip sudo fzf archlinux macos cp zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

source "$OH_MY_ZSH/oh-my-zsh.sh"

eval "$(starship init zsh)"

source "$HOME/.zsh/alias.zsh"
source "$HOME/.zsh/path.zsh"
source "$HOME/.zsh/gpg.zsh"
source "$HOME/.zsh/fzf.zsh"

# VMN's generated cd wrapper is replaced by zoxide below. Keep automatic
# project Node version switching as a directory-change hook instead.
eval "$(vmn env zsh)"
autoload -Uz add-zsh-hook
add-zsh-hook -d chpwd setNodeVersion 2>/dev/null
add-zsh-hook chpwd setNodeVersion

# Zoxide owns cd so directory names can be resolved from its database.
eval "$(zoxide init --cmd cd zsh)"

eval "$(kubectl completion zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.local/bin:$PATH"

export PATH=~/.npm-global/bin:$PATH

# pnpm
export PNPM_HOME="/home/vineel/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

export TERM="xterm-256color"

export PATH=".rustup/toolchains/stable-aarch64-apple-darwin/bin:$PATH"

# >>> keygate >>>
export SSH_AUTH_SOCK="/var/folders/c7/t756y52j7_q0t7fl2ff7hvfm0000gn/T/keygate-501/agent.sock"
# <<< keygate <<<

#VMN 
eval "`vmn env`"