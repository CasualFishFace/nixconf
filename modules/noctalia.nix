{inputs, moduleWithSystem, ...}: {
  flake.nixosModules.noctalia = moduleWithSystem ({self', system, ...}:
    {config, lib, ...}:
    {
      nix.settings = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
      };

      programs.noctalia = {
        enable = lib.mkDefault true;
        package = inputs.noctalia.packages.${system}.default;
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
        themes.noctalia = builtins.readFile ./../themes/apps/helix/noctalia.toml;
      });

      systemd.tmpfiles.rules = [
        "L+ /etc/nixos/themes/apps/helix - - - - /home/fishface/.config/helix/themes"
      ];
    }
  );
}
