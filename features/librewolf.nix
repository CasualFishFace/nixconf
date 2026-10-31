{ moduleWithSystem, ... }: {
  # perSystem = { pkgs, ... }: {
  #   packages.librewolf = pkgs.librewolf;
  # };

  flake.wrappers.librewolf = { pkgs, wlib, ... }: {
    imports = [ wlib.modules.default ];
    options = {};
    config = {
      package = pkgs.librewolf;
    };
  };

  flake.nixosModules.librewolf = moduleWithSystem ({ self', ... }: {
    environment.systemPackages = [ self'.packages.librewolf ];
  });
}
