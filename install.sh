#!/usr/bin/env bash
set -euo pipefail

DOTFILE_DIR="$(cd "$(dirname "$0")" && pwd)"

# nix (https://determinate.systems/nix-installer/)
if ! command -v nix &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    # shellcheck source=/dev/null
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# nix home-manager
export DOTFILES_DIR="$DOTFILE_DIR"
nix run home-manager/master -- switch -b backup --impure --flake "$DOTFILE_DIR"
