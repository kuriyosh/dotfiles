#!/bin/bash

DOTFILE_DIR=$(cd $(dirname $0); pwd)

# nix (https://determinate.systems/nix-installer/)
if ! command -v nix &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# nix home-manager
export DOTFILES_DIR=$DOTFILE_DIR
nix run home-manager/release-24.11 -- switch --impure --flake "$DOTFILE_DIR"

if [[ "$(uname)" == "Darwin" ]]; then
    read -p "Did you signin to App Store? (y/N): " yn
    case "$yn" in
        [yY]*) echo "good."
        *) exit 1;;
    esac

    # brew (https://brew.sh/)
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # brew
    brew bundle --file $DOTFILE_DIR/Brewfile

    # oh-my-zsh (https://github.com/ohmyzsh/ohmyzsh)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # macOS settings
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
    defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 6
    defaults -currentHost write -globalDomain NSStatusItemSpacing -int 6
    defaults write com.apple.dock wvous-br-corner -int 0
fi