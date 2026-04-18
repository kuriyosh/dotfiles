{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      username = builtins.getEnv "USER";
      homeDirectory = builtins.getEnv "HOME";
      system = builtins.currentSystem;
      isDarwin = builtins.match ".*-darwin" system != null;

      dotfilesDir =
        let dir = builtins.getEnv "DOTFILES_DIR";
        in if dir != "" then dir else "${homeDirectory}/projects/dotfiles";
    in
    {
      homeConfigurations.${username} =
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./nix/home.nix
            ./nix/dotfiles/shared.nix
          ] ++ (if isDarwin then [ ./nix/dotfiles/darwin.nix ] else []);
          extraSpecialArgs = {
            inherit username homeDirectory dotfilesDir;
          };
        };
    };
}
