{ inputs, outputs, myLib, ... }: {
  flake.homeManagerModules.default = {
    extraSpecialArgs = { inherit inputs outputs myLib; };
    imports = [
      ./bundles
      ./programs
      ./services
      ./system
      ./themes
    ];
  };
}
