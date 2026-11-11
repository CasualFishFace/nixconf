{moduleWithSystem, ...}: {
  flake.nixosModules.noctalia = moduleWithSystem (
    {inputs', self', ...}:
    {config, lib, ...}:
    {
      options = {
        programs.noctalia.extraConfig = lib.mkOption {
          default = ./config.toml;
          type = with lib.types; nullOr path;
        };
      };
      config = {
        nix.settings = {
          extra-substituters = [ "https://noctalia.cachix.org" ];
          extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
        };

        programs.noctalia = {
          enable = lib.mkDefault true;
          package = lib.mkDefault inputs'.noctalia.packages.default;
          recommendedServices.enable = lib.mkDefault true;
          systemd.enable = lib.mkDefault false;
        };

        programs.ghostty.package = lib.mkIf (
          config.programs.noctalia.enable
        ) (self'.packages.ghostty.wrap {
          settings.theme = "noctalia";
        });

        programs.helix.package = lib.mkIf (
          config.programs.noctalia.enable
        ) (self'.packages.helix.wrap {
          settings.theme = "noctalia";
          drv.postBuild = ''
            themes="${placeholder "out"}/hx-config/helix/themes"
            mkdir -p "$themes"
            ln -s /home/fishface/.config/helix/themes/noctalia.toml "$themes/noctalia.toml"
          '';
        });

        programs.niri.package = lib.mkIf (
          config.programs.noctalia.enable
        ) (self'.packages.niri.wrap {
          browser = self'.packages.librewolf;
          terminal = config.programs.ghostty.package;
          settings.extraConfig = ''
            include optional=true "./lib/noctalia.kdl"
          '';
          drv.postBuild = ''
            cfg="${placeholder "out"}/lib"
            mkdir -p "$cfg"
            ln -s /home/fishface/.config/niri/noctalia.kdl "$cfg/noctalia.kdl"
          '';
        });

        systemd.tmpfiles.rules =
          let
            noctalia-enable = config.programs.noctalia.enable;
            cfg = config.programs.noctalia.extraConfig;
          in
          lib.mkIf (noctalia-enable && cfg != null) [
            "L+ /home/fishface/.config/noctalia/config.toml - - - - ${cfg}"
          ];
      };
    }
  );
}
