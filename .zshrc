export OH_MY_ZSH="$HOME/.zsh/ohmyzsh"

plugins=(git gh pip sudo fzf archlinux macos cp zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-history-substring-search)

source "$OH_MY_ZSH/oh-my-zsh.sh"

eval "$(starship init zsh)"

source "$HOME/.zsh/alias.zsh"
source "$HOME/.zsh/path.zsh"
source "$HOME/.zsh/gpg.zsh"
source "$HOME/.zsh/fzf.zsh"

# VMN
eval "`vmn env`"
eval "`vmp env`"

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

fastfetch

