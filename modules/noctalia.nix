{inputs, moduleWithSystem, ...}: {
  flake.nixosModules.noctalia = moduleWithSystem ({self', system, ...}:
    {config, lib, ...}:
    let
      noctaliaMk = wrapped: lib.mkIf config.programs.noctalia.enable wrapped;
    in
    {
      nix.settings = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
      };

      programs.noctalia = {
        enable = lib.mkDefault true;
        package = inputs.noctalia.packages.${system}.default;
        recommendedServices.enable = lib.mkDefault true;
        systemd.enable = lib.mkDefault false;
      };

      programs.ghostty.package = lib.mkIf (
        config.programs.noctalia.enable
      ) (self'.packages.ghostty.wrap {
        settings.theme = "noctalia";
      });

      programs.helix.package = noctaliaMk (self'.packages.helix.wrap {
        settings.theme = "noctalia";
        drv.postBuild = ''
          themes="${placeholder "out"}/hx-config/helix/themes"
          mkdir -p "$themes"
          ln -s $HOME/.config/helix/themes/noctalia.toml "$themes/noctalia.toml"
        '';
      });

      programs.niri.package = noctaliaMk (self'.packages.niri.wrap {
        drv.postBuild = ''
          cfg="${placeholder "out"}"
          mkdir -p "$cfg"
          ln -s $HOME/.config/niri/noctalia.kdl "$cfg/noctalia.kdl"
        '';
      });
    }
  );
}
