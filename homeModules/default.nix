{
  flake.homeModules.default = {
    imports = [
      ./bundles
      ./programs
      ./services
      ./system
      ./themes
    ];
  };
}
