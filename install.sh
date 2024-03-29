#!/bin/bash

DOTFILE_DIR=$(cd $(dirname $0); pwd)

read -p "Did you signin to App Store? (y/N): " yn
case "$yn" in
    [yY]*) echo "good."
    *) exit 1;;
esac

# brew (https://brew.sh/)
if !(command brew -v > /dev/null 2>&1); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

cd $DOTFILE_DIR
brew bundle --file $DOTFILE_DIR/Brewfile

# zsh
ln -s $DOTFILE_DIR/.zprofile ~/.zprofile
ln -s $DOTFILE_DIR/.zshrc ~/.zshrc

# Keybind
mkdir -p ~/Library/KeyBindings
ln -s $DOTFILE_DIR/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict

# scripts
ln -s $DOTFILE_DIR/.scripts ~/.scripts

# git
ln -s $DOTFILE_DIR/.gitconfig ~/.gitconfig
ln -s $DOTFILE_DIR/.gitmessage ~/.gitmessage

# hyper
ln -s $DOTFILE_DIR/.hyper.js ~/.hyper.js

# nvm (https://github.com/nvm-sh/nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# oh-my-zsh (https://github.com/ohmyzsh/ohmyzsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"