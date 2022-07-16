#!/bin/bash

DOTFILE_DIR=$(cd $(dirname $0); pwd)

read -p "Did you signin to App Store? (y/N): " yn
case "$yn" in
    [yY]*) echo "good."
    *) exit 1;;
esac

# brew
if !(command brew -v > /dev/null 2>&1); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

cd $DOTFILE_DIR
brew bundle --file $DOTFILE_DIR/Brewfile

# zsh
ln -s $DOTFILE_DIR/.zprofile ~/.zprofile

# fish
mkdir ~/.config
ln -s $DOTFILE_DIR/fish ~/.config/fish

git clone https://github.com/edc/bass.git
cd bass
make install

## omf (https://github.com/oh-my-fish/oh-my-fish)
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
ln -s $DOTFILE_DIR/omf ~/.config/omf
omf install

# Keybind
mkdir -p ~/Library/KeyBindings
ln -s $DOTFILE_DIR/DefaultKeyBinding .dict ~/Library/KeyBindings/DefaultKeyBinding.dict

# scripts
ln -s $DOTFILE_DIR/.scripts ~/.scripts

# git
ln -s $DOTFILE_DIR/.gitconfig ~/.gitconfig
ln -s $DOTFILE_DIR/.gitmessage ~/.gitmessage