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
      mkHome = system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./nix/home.nix ];
          extraSpecialArgs = {
            username = builtins.getEnv "USER";
            homeDirectory = builtins.getEnv "HOME";
          };
        };
    in
    {
      homeConfigurations = {
        "aarch64-darwin" = mkHome "aarch64-darwin";
        "x86_64-linux" = mkHome "x86_64-linux";
      };
    };
}
