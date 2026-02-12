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

# run dotbot
./install

# brew
brew bundle --file $DOTFILE_DIR/Brewfile

# oh-my-zsh (https://github.com/ohmyzsh/ohmyzsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install cursor extensions
cat ./cursor/extensions.txt | xargs -I {} cursor --install-extension {}

# macOS settings
defaults write com.apple.dock autohide -bool true
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 6
defaults -currentHost write -globalDomain NSStatusItemSpacing -int 6
defaults write com.apple.dock wvous-br-corner -int 0

curl -sS https://starship.rs/install.sh | sh