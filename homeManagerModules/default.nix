{ inputs, ... }: {
  imports = [
    ./bundles
    ./programs
    ./services
    ./system
    ./themes

    inputs.stylix.homeModules.stylix
  ];
}
