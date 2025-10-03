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

  themes = rec {
    dir = ./../themes;

    path = name: if name != null then "${dir}/${name}" else null;

    wallpaper = name: let
      directory = path name;
      fileName = firstFileStartingWith directory "wallpaper.";
      p = "${directory}/${fileName}";
    in if name != null && builtins.pathExists p then p else null;

    scheme = name: let
      directory = path name;
      p = "${directory}/scheme.yaml";
    in if name != null && builtins.pathExists p then p else null;
  };

  # stylixConfig = {
  #   enable ? true,
  #   fonts ? null,
  #   polarity ? "dark",
  #   themeName ? null,
  # }: let
  #   scheme = themes.scheme themeName;
  #   wallpaper = themes.wallpaper themeName;
  # in {
  #   inherit enable polarity;
  #   ${if fonts != null then "fonts" else null} = fonts;
  #   ${if wallpaper != null then "image" else null} = wallpaper;
  #   ${if builtins.pathExists scheme then "base16Scheme" else null} = scheme;
  # };
}
