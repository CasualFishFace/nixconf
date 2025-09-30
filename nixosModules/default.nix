{ flake-inputs, ... }: {
  imports = [
    flake-inputs.home-manager.nixosModules.home-manager
    ./bundles
    ./programs
    ./services
    ./system
  ];
}
