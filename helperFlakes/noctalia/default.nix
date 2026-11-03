{inputs, ...}: {
  flake.wrappers.noctalia = {config, pkgs, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    config = {
      package = inputs.noctalia.packages.${system}.default;
      inherit (config)
        recommendedServices
        systemd;
    };
  };
}
