{ self, ... }: {
  flake.nixosModules.bundles = { config, lib, ... }: {
    options.myNixos.bundles = {
      graphical.enable = lib.mkEnableOption ''
        Configures many options that would be nice on a graphical interface.
      '';
    };

    config = let
      inherit (config.myNixos) bundles;
    in lib.mkIf bundles.graphical.enable {
      imports = [
        /etc/nixos/hardware-configuration.nix
        self.nixosModules.essential
        self.nixosModules.users
      ];
    };
  };
}
