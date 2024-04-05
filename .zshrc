source "$HOME/.zsh/path.zsh"
source "$HOME/.zsh/alias.zsh"
source "$HOME/.zsh/nvm.zsh"
source "$HOME/.zsh/gpg.zsh"

export ZSH="$HOME/.zsh/ohmyzsh"
source "$ZSH/oh-my-zsh.sh"

source "$ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH/custom/plugins/zsh-completions/zsh-completions.plugin.zsh"
source "$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

eval "$(starship init zsh)"

if command -v brew &> /dev/null; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

#VMN
eval "`vmn env`"

