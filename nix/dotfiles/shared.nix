{ config, lib, dotfilesDir, ... }:

let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${path}";
in
{
  home.file = {
    ".config/home-manager".source = mkSymlink "";
    ".config/starship.toml".source = mkSymlink "starship/starship.toml";
    ".emacs.d/init.el".source = mkSymlink ".emacs.d/init.el";
    ".emacs.d/early-init.el".source = mkSymlink ".emacs.d/early-init.el";
    ".emacs.d/cli.el".source = mkSymlink ".emacs.d/cli.el";
    ".config/tmux".source = mkSymlink "tmux";
    ".config/mise/config.toml".source = mkSymlink "mise/config.toml";
  };
}
