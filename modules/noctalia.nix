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

      programs.helix.package = lib.mkIf (
        config.programs.noctalia.enable
      ) (self'.packages.helix.wrap {
        settings.theme = "noctalia";
        themes.noctalia = let
          result = builtins.tryEval ./../themes/noctalia-helix.toml;
        in if result.success then
          builtins.readFile result.value
        else
          "inherits = \"custom\"";
      });

      systemd.tmpfiles.rules = [
        "L+ /etc/nixos/themes/noctalia-helix.toml - - - - /home/fishface/.config/helix/themes/noctalia.toml"
      ];
    }
  );
}
