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
      inherit (nixpkgs) lib;

      # ユーザ名は $USER から取る (switch 時は --impure が必要)。
      # pure 評価 (CI) では getEnv が "" を返すので placeholder "ci" で評価する
      username =
        let u = builtins.getEnv "USER";
        in if u != "" then u else "ci";

      systems = [ "aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux" ];

      mkHome = system:
        let
          isDarwin = lib.hasSuffix "-darwin" system;
          homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./nix/home.nix
            ./nix/dotfiles/shared.nix
          ] ++ lib.optionals isDarwin [ ./nix/dotfiles/darwin.nix ];
          extraSpecialArgs = {
            inherit username homeDirectory;
            dotfilesDir = "${homeDirectory}/projects/dotfiles";
          };
        };
    in
    {
      homeConfigurations = lib.listToAttrs (map
        (system: {
          name = "${username}@${system}";
          value = mkHome system;
        })
        systems)
      # --impure のときだけ現在のマシン向け短縮名を生やす。
      # home-manager switch は $USER 名の構成を自動で解決する
      // lib.optionalAttrs (builtins ? currentSystem) {
        ${username} = mkHome builtins.currentSystem;
      };
    };
}
