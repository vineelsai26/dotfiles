#!/bin/bash

current=$pwd
git clone --bare https://github.com/vineelsai26/dotfiles $HOME/.cfg
git --git-dir=$HOME/.cfg/ --work-tree=$HOME stash
git --git-dir=$HOME/.cfg/ --work-tree=$HOME reset --hard
git --git-dir=$HOME/.cfg/ --work-tree=$HOME submodule init
git --git-dir=$HOME/.cfg/ --work-tree=$HOME submodule update
cd $HOME/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions
cd $current
zsh
cat $HOME/.bash_history >>$HOME/.zsh_history
