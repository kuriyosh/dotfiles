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

# oh-my-zsh (https://github.com/ohmyzsh/ohmyzsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"