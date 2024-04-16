source "$HOME/.zsh/path.zsh"
source "$HOME/.zsh/alias.zsh"
source "$HOME/.zsh/gpg.zsh"

export OH_MY_ZSH="$HOME/.zsh/ohmyzsh"
source "$OH_MY_ZSH/oh-my-zsh.sh"

source "$OH_MY_ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$OH_MY_ZSH/custom/plugins/zsh-completions/zsh-completions.plugin.zsh"
source "$OH_MY_ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

eval "$(starship init zsh)"

if command -v brew &> /dev/null; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

#VMN
eval "`vmn env`"

