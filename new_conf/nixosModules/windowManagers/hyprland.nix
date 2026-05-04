_top: {
  flake.nixosModules.windowManagers = { lib, ... }: {
    programs.hyprland.xwayland.enable = lib.mkDefault true;
  };
}
