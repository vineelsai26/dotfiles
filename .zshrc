export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="xiong-chiamiov-plus"

plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

source $HOME/.zsh/alias.zsh
source $HOME/.zsh/nvm.zsh
source $HOME/.zsh/gpg.zsh

# bun completions
[ -s "/home/vineel/.bun/_bun" ] && source "/home/vineel/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"

# PATH
export PATH="$HOME/.local/bin:$BUN_INSTALL/bin:$PATH"

eval "$(fnm env --use-on-cd)"

# fnm
export PATH="/home/vineel/.local/share/fnm:$PATH"
eval "`fnm env`"
