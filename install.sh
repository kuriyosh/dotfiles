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

fi
