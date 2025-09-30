{ inputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./bundles
    ./programs
    ./services
    ./system
  ];
}
