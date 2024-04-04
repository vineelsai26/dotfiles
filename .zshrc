source "$HOME/.zsh/path.zsh"
source "$HOME/.zsh/alias.zsh"
source "$HOME/.zsh/nvm.zsh"
source "$HOME/.zsh/gpg.zsh"

source "$HOME/.zsh/ohmyzsh/oh-my-zsh.sh"

eval "$(starship init zsh)"

if command -v brew &> /dev/null; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

#VMN
eval "`vmn env`"

