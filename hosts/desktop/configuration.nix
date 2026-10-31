{ self, mylib, ... }: let
  inherit (mylib) mkHost;
in {
  flake.nixosConfigurations.desktop = with self.nixosModules; mkHost "desktop" [
    ./_hardware-configuration.nix

    audio
    bootloader
    minimalSystem
    networking
    nvidia
    time
    users

    ({ pkgs, ... }: {
      services.displayManager = {
        ly.enable = true;
      };

      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
      };
    })
  ];
}
