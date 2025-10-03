inputs@{ self, nixpkgs, home-manager, ... }: let
  lib = import ./default.nix inputs;
  inherit (self) outputs;
in rec {
  # Helper functions ==========================================================

  firstFileStartingWith = directory: prefix: let
    entries = builtins.readDir directory;
    filtered = nixpkgs.lib.filterAttrs (name: type:
      (type == "regular") &&
      (nixpkgs.lib.hasPrefix prefix name)
    ) entries;
  in builtins.head (builtins.attrNames filtered);

  dirsIn = dir: let
    entries = builtins.readDir dir;
    filtered = nixpkgs.lib.filterAttrs (_: t: t == "directory") entries;
  in builtins.attrNames filtered;

  usersOnHost = host: dirsIn ./../hosts/${host}/users;

  # NixOS system functions ====================================================
  
  mkAllSystems = hosts: nixpkgs.lib.genAttrs hosts mkSystem;
  mkSystem = host: let
    config = ./../hosts/${host}/configuration.nix;
    # users = usersOnHost host;
  in nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; myLib = lib; };
    modules = [
      config
      self.outputs.nixosModules.default
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
    extraSpecialArgs = { inherit inputs outputs; myLib = lib; };
    modules = [
      config
      self.outputs.homeMangerModules.default
      inputs.stylix.homeModules.stylix
    ];
  };

  # Theme functions ===========================================================

  themesDirectory = ./../themes;

  themePath = themeName: if (themeName != null)
    then "${themesDirectory}/${themeName}"
    else null;

  themeWallpaper = themeName: let
    directory = themePath themeName;
    fileName = firstFileStartingWith directory "wallpaper.";
  in if (themeName != null)
    then "${directory}/${fileName}"
    else null;
}
