{moduleWithSystem, ...}: {
  flake.nixosModules.noctalia = moduleWithSystem (
    {inputs', self', ...}:
    {config, lib, ...}:
    {
      options = {
        programs.noctalia.extraConfig = lib.mkOption {
          default = null;
          type = with lib.types; nullOr (oneOf [ path str ]);
        };
      };
      config = {
        nix.settings = {
          extra-substituters = [ "https://noctalia.cachix.org" ];
          extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
        };

        programs.noctalia = {
          enable = lib.mkDefault true;
          package = lib.mkDefault inputs'.packages.noctalia;
          recommendedServices.enable = lib.mkDefault true;
          systemd.enable = lib.mkDefault false;
          extraConfig = lib.mkDefault ./config.toml;
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
            result = builtins.tryEval (
              builtins.readFile config.programs.noctalia.extraConfig
            );
            cfg =
              if result.success
              then result.value
              else config.programs.noctalia.extraConfig;
          in
          [ "f+ /home/fishface/.config/noctalia/config.toml - - - - ${cfg}" ];
      };
    }
  );
}
