source "$HOME/.zsh/path.zsh"
source "$HOME/.zsh/alias.zsh"
source "$HOME/.zsh/nvm.zsh"
source "$HOME/.zsh/gpg.zsh"

eval "$(starship init zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#VMN
eval "`vmn env`"

