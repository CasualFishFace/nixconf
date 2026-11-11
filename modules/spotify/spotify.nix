{...}: {
  flake.nixosModules.spotify = {config, pkgs, lib, ...}: {
    options.programs.spotify.enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
    };

    config.environment.systemPackages = lib.mkIf (
      config.programs.spotify.enable
    ) [ pkgs.spotify ];
  };
}
