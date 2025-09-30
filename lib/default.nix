inputs@{ self, nixpkgs, home-manager, ... }: rec {
  # Helper functions ==========================================================

  usersOnHost = host: nixpkgs.lib.filterAttrs (
    name: _: nixpkgs.lib.hasSuffix "@${host}" name
  ) self.outputs.homeConfigurations;

  # NixOS system functions ====================================================
  
  mkAllSystems = hosts: nixpkgs.lib.genAttrs hosts mkSystem;
  mkSystem = host: let
    config = ./../hosts/${host}/configuration.nix;
  in nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      config
      self.outputs.nixosModules.default
      {
        home-manager = {
          backupFileExtension = "bak";
          useGlobalPkgs = true;
          useUserPackages = true;
          users = usersOnHost host;
        };
      }
    ];
  };

  # Home Manager functions ====================================================

  mkAllHomes = users: let
    attrsList = builtins.mapAttrs (name: entry:
      builtins.map (host: {
        "${name}@${host}" = mkHome name host;
      }) entry.hosts
    ) users;
  in nixpkgs.lib.mergeAttrsList attrsList;

  mkHome = name: host: let
    config = ./../hosts/${host}/users/${name};
    system = self.outputs.nixosConfigurations.${host}.nixpkgs.hostPlatform;
  in home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs { inherit system; };
    extraSpecialArgs = { inherit inputs; };
    modules = [ config self.outputs.homeMangerModules.default ];
  };
}
