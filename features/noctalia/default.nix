{ inputs, ... }: {
  flake.wrappers.noctalia = { config, pkgs, ... }: let
    # inherit (pkgs.stdenv.hostPlatform) system;
  in {
    config = {
      package = pkgs.noctalia;      
      inherit (config)
        recommendedServices
        systemd;
    };
  };
}
