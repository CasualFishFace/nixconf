inputs@{ self, nixpkgs, home-manager, ... }: rec {
  # Helper functions ==========================================================

  usersOnHost = host: let
    fullUsers = builtins.filter
      (nixpkgs.lib.hasSuffix "@${host}")
      (builtins.attrNames self.outputs.homeConfigurations);
  in builtins.map (nixpkgs.lib.removeSuffix "@${host}") fullUsers;

  homeFilesOnHost = host: builtins.map (name: ./../hosts/${host}/users/${name}) (usersOnHost host);

  # NixOS system functions ====================================================
  
  mkAllSystems = hosts: nixpkgs.lib.genAttrs hosts mkSystem;
  mkSystem = host: let
    config = ./../hosts/${host}/configuration.nix;
    homeFiles = homeFilesOnHost host;
  in nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      config
      self.outputs.nixosModules.default
    ] ++ homeFiles;
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
