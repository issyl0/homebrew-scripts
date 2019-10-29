#!/bin/bash

sudo apt-get update

sudo apt-get install build-essential curl file git
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

source ~/.bash_profile
source ~/.profile

mkdir ~/repos
git clone https://github.com/issyl0/dotfiles ~/repos/dotfiles
ln -s ~/repos/dotfiles/.vimrc ~/.vimrc
ln -s ~/repos/dotfiles/.zshrc ~/.zshrc
ln -s ~/repos/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/repos/dotfiles/.gitignore_global ~/.gitignore_global

brew update
brew install gcc
brew bundle --file=~/repos/dotfiles/Brewfile

# Make Yubikey work.
gpg --recv-keys 0x8247C390DADC67D4
mkdir ~/.gnupg
ln -s ~/repos/dotfiles/gpg-agent.conf ~/.gnupg/gpg-agent.conf
ln -s ~/repos/dotfiles/gnupg.conf ~/.gnupg/gpg.conf

echo "All done? Maybe?"
