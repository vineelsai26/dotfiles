export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="xiong-chiamiov-plus"

plugins=(zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

source "$HOME/.zsh/alias.zsh"
source "$HOME/.zsh/nvm.zsh"
source "$HOME/.zsh/gpg.zsh"
source "$HOME/.zsh/path.zsh"

test -e "${HOME}/.zsh/.iterm2_shell_integration.zsh" && source "${HOME}/.zsh/.iterm2_shell_integration.zsh"

#VMN 
eval "`vmn env`"

neofetch

# pnpm
export PNPM_HOME="/Users/vineel/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end