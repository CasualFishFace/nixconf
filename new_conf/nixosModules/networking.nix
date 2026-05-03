_top: {
  flake.nixosModules.networking = {
    networking.networkmanager.enable = true;
  };
}
