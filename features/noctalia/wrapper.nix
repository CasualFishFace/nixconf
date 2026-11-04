{inputs, ...}: {
  flake.wrappers.noctalia = { pkgs, wlib, lib, ... }: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    imports = [
      wlib.modules.default
    ];
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
    config = {
      runtimePkgs = [
        inputs.noctalia.packages.${system}.default
      ];

      config-path = ./noctalia-full-config.toml;
    };
  };
}
