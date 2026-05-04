_top: {
  flake.nixosModules.displayManagers = { lib, ... }: {
    services.displayManager.gdm.wayland = lib.mkDefault true;
  };
}
