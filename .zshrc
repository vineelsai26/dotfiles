export OH_MY_ZSH="$HOME/.zsh/ohmyzsh"

plugins=(git gh pip sudo fzf archlinux macos cp zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

source "$OH_MY_ZSH/oh-my-zsh.sh"

eval "$(starship init zsh)"

source "$HOME/.zsh/alias.zsh"
source "$HOME/.zsh/path.zsh"
source "$HOME/.zsh/gpg.zsh"
source "$HOME/.zsh/fzf.zsh"

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

eval "$(kubectl completion zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


. "$HOME/.local/bin/env"

# Hermes Agent — ensure ~/.local/bin is on PATH
export PATH="$HOME/.local/bin:$PATH"

export PATH=~/.npm-global/bin:$PATH


# pnpm
export PNPM_HOME="/home/vineel/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
