inputs@{ self, nixpkgs, home-manager, ... }: rec {

  # NixOS system functions ====================================================
  
  mkAllSystems = hosts: nixpkgs.lib.genAttrs hosts mkSystem;
  mkSystem = host: let
    config = ./../hosts/${host}/configuration.nix;
  in nixpkgs.lib.nixosSystem {
    specialArgs = { flake-inputs = inputs; };
    modules = [ config self.outputs.nixosModules.default ];
  };

  # Home Manager functions ====================================================

  mkHome = name: host: let
    config = ./../hosts/${host}/users/${name}/home.nix;
    system = self.outputs.nixosConfigurations.${host}.nixpkgs.hostPlatform;
  in home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs { inherit system; };
    extraSpecialArgs = { flake-inputs = inputs; };
    modules = [ config ];
  };
}
