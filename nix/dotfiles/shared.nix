{ config, lib, homeDirectory, dotfilesDir, ... }:

let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${path}";
in
{
  home.activation.ohmyzsh = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${homeDirectory}/.oh-my-zsh" ]; then
      run /usr/bin/git clone https://github.com/ohmyzsh/ohmyzsh.git "${homeDirectory}/.oh-my-zsh"
    fi
  '';

  home.file = {
    ".config/home-manager".source = mkSymlink "";
    ".config/starship.toml".source = mkSymlink "starship/starship.toml";
    # ".config/zed".source = mkSymlink "zed";
    ".zshrc".source = mkSymlink "zsh/.zshrc";
    # ".warp/keybindings.yaml".source = mkSymlink "warp/keybindings.yaml";
    ".emacs.d/init.el".source = mkSymlink ".emacs.d/init.el";
    ".emacs.d/early-init.el".source = mkSymlink ".emacs.d/early-init.el";
    ".config/tmux".source = mkSymlink "tmux";
    ".default-npm-packages".source = mkSymlink ".default-npm-packages";
  };
}
