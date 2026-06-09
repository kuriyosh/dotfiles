#!/usr/bin/env bash
set -euo pipefail

DOTFILE_DIR="$(cd "$(dirname "$0")" && pwd)"

find_executable() {
    local name="$1"
    shift

    if command -v "$name" > /dev/null 2>&1; then
        command -v "$name"
        return
    fi

    local candidate
    for candidate in "$@"; do
        if [ -x "$candidate" ]; then
            printf '%s\n' "$candidate"
            return
        fi
    done

    return 1
}

# nix (https://determinate.systems/nix-installer/)
if ! command -v nix &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    # shellcheck source=/dev/null
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# nix home-manager
export DOTFILES_DIR="$DOTFILE_DIR"
nix run home-manager/master -- switch -b backup --impure --flake "$DOTFILE_DIR"

# homebrew (macOS only)
if [ "$(uname -s)" = "Darwin" ]; then
    if brew_bin="$(find_executable brew /opt/homebrew/bin/brew /usr/local/bin/brew)"; then
        "$brew_bin" bundle --file="$DOTFILE_DIR/Brewfile"
    else
        echo "brew command not found after Home Manager activation" >&2
        exit 1
    fi
fi

# mise
if mise_bin="$(find_executable mise "$HOME/.nix-profile/bin/mise" "/etc/profiles/per-user/$USER/bin/mise")"; then
    (cd "$DOTFILE_DIR" && "$mise_bin" install)
else
    echo "mise command not found after Home Manager activation" >&2
    exit 1
fi
