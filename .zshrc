export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="xiong-chiamiov-plus"

plugins=(zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

source $HOME/.zsh/alias.zsh
source $HOME/.zsh/nvm.zsh
source $HOME/.zsh/gpg.zsh

# bun completions
[ -s "/home/vineel/.bun/_bun" ] && source "/home/vineel/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# PATH
export PATH="$HOME/.local/bin:$BUN_INSTALL/bin:$PATH"
export PATH="$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"
export PATH="$HOME/Personal/VMN:$PATH"

#VMN 
eval "`vmn env`"
