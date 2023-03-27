git clone --bare https://github.com/vineelsai26/dotfiles $HOME/.cfg
git --git-dir=$HOME/.cfg/ --work-tree=$HOME stash
git --git-dir=$HOME/.cfg/ --work-tree=$HOME reset --hard
git --git-dir=$HOME/.cfg/ --work-tree=$HOME submodule init
git --git-dir=$HOME/.cfg/ --work-tree=$HOME submodule update
cd .oh-my-zsh
git submodule init
git submodule update
cd ~
chsh -s /bin/zsh
zsh
