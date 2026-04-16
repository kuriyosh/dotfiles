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
      currentSystem = builtins.currentSystem;
      isDarwin = builtins.match ".*-darwin" currentSystem != null;

      dotfilesDir =
        let dir = builtins.getEnv "DOTFILES_DIR";
        in if dir != "" then dir else "${homeDirectory}/projects/dotfiles";

      mkHome = extraModules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${currentSystem};
          modules = [
            ./nix/home.nix
            ./nix/dotfiles/shared.nix
          ] ++ extraModules;
          extraSpecialArgs = {
            inherit username homeDirectory dotfilesDir;
          };
        };
    in
    {
      homeConfigurations = {
        "${username}" = mkHome (
          if isDarwin then [ ./nix/dotfiles/darwin.nix ] else []
        );
      };
    };
}
