{ inputs, ... }: let
  inherit (inputs.nixpkgs) lib;
in {
  flake.nixosModules.time = {
    time.timeZone = lib.mkForce null;
    services.automatic-timezoned.enable = true;
    dconf.settings = {
      "org/gnome/desktop/datetime" = {
        automatic-timezone = true;
      };
      "org/gnome/system/location" = {
        enabled = true;
      };
    };
  };
}
