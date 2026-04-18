{ config, pkgs, lib, username, homeDirectory, ... }:

{
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # utilities
    colordiff
    jq
    lesspipe
    nkf
    sourceHighlight
    inetutils
    ripgrep
    tree
    bat
    eza
    duckdb
    btop

    # git
    pkgs.git-lfs
    gh

    # cloud
    awscli2

    # shell
    starship
    zoxide
    carapace
    tmux

    # dev tools
    mise
  ] ++ lib.optionals stdenv.isDarwin [
    mas
  ];

  programs.home-manager.enable = true;
}
