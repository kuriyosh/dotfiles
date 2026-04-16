{ config, dotfilesDir, ... }:

let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${path}";
in
{
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
