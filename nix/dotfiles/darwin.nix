{ config, lib, dotfilesDir, ... }:

let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${path}";
in
{
  home.activation.homebrew = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # Install Homebrew if not present
    if [ ! -x /opt/homebrew/bin/brew ] && [ ! -x /usr/local/bin/brew ]; then
      run /bin/bash -c "NONINTERACTIVE=1 $(/usr/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  '';

  home.activation.macosDefaults = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # Dock: auto-hide
    run /usr/bin/defaults write com.apple.dock autohide -bool true
    # Disable click desktop to show Desktop
    run /usr/bin/defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
    # Reduce menu bar item spacing
    run /usr/bin/defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 6
    run /usr/bin/defaults -currentHost write -globalDomain NSStatusItemSpacing -int 6
    # Disable hot corner (bottom-right)
    run /usr/bin/defaults write com.apple.dock wvous-br-corner -int 0
  '';

  home.file = {
    ".config/ghostty/config".source = mkSymlink "ghostty/config";
    ".config/karabiner".source = mkSymlink "karabiner";
    "Library/KeyBindings/DefaultKeyBinding.dict".source = mkSymlink "macOS/DefaultKeyBinding.dict";
    "Library/Application Support/Cursor/User/keybindings.json".source = mkSymlink "cursor/keybindings.json";
    "Library/Application Support/Cursor/User/settings.json".source = mkSymlink "cursor/settings.json";
    "Library/Application Support/Code/User/settings.json".source = mkSymlink "vscode/settings.json";
    "Library/Application Support/Code/User/keybindings.json".source = mkSymlink "vscode/keybindings.json";
    "Library/Keyboard Layouts/kuriyosh.keylayout".source = mkSymlink "macOS/kuriyosh.keylayout";
  };
}
