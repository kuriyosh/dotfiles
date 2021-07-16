#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

read -p "Did you signin to App Store? (y/N): " yn
case "$yn" in
    [yY]*) echo "good."
    *) exit 1;;
esac

# brew
if !(command brew -v > /dev/null 2>&1); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

cd $SCRIPT_DIR
brew bundle --file $SCRIPT_DIR/Brewfile

# zsh
ln -s ~/.zprofile $SCRIPT_DIR/.zprofile

# fish
mkdir ~/.config
ln -s ~/.config/fish $SCRIPT_DIR/fish

## omf
curl -L https://get.oh-my.fish | fish
ln -s ~/Development/dotfiles/omf ~/.config/omf
omf install

# Keybind
mkdir -p ~/Library/KeyBindings
ln -s ~/Library/KeyBindings/DefaultKeyBinding.dict $SCRIPT_DIR/DefaultKeyBinding.dict

# scripts
ln -s ~/.scripts $SCRIPT_DIR/.scripts

# Emacs
mkdir -p ~/.emacs.d
ln -s ~/.emacs.d $SCRIPT_DIR/.emacs.d

# git
ln -s ~/.gitconfig $SCRIPT_DIR/.gitconfig
ln -s ~/.gitmessage $SCRIPT_DIR/.gitmessage