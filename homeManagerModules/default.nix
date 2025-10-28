{
  flake.homeManagerModules.default = {
    imports = [
      ./bundles
      ./programs
      ./services
      ./system
      ./themes
    ];
  };
}
