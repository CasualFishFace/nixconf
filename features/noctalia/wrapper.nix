{inputs, ...}: {
  flake.wrappers.noctalia = {pkgs, lib, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    options = {
      recommendedServices.enable = lib.mkEnableOption ''
        Enables wifi, bluetooth, power-profile, and battery features.
      '';
      systemd.enable = lib.mkEnableOption ''
        Enables noctalia as a systemd service.
      '';
      config-path = lib.mkOption {
        type = with lib.types; nullOr path;
      };
    };
  };
}
