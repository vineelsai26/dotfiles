source "$HOME/.zsh/path.zsh"
source "$HOME/.zsh/alias.zsh"
source "$HOME/.zsh/gpg.zsh"

eval "$(starship init bash)"

#VMN 
eval "`vmn env`"

. "$HOME/.cargo/env"
