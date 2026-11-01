{ self, mylib, ... }: let
  inherit (mylib) mkHost;
in {
  flake.nixosConfigurations.desktop = with self.nixosModules; mkHost "desktop" [
    ./_hardware-configuration.nix

    audio
    bootloader
    librewolf
    minimalSystem
    networking
    niri
    nvidia
    time
    users
    zsh

    ({ pkgs, ... }: {
      services.displayManager = {
        ly.enable = true;
      };

      services.udev.extraRules = ''
        SUBSYSTEM=="hidraw", ATTRS{idProduct}=="3208", ATTRS{idVendor}=="2dc8", TAG+="uaccess"
        SUBSYSTEM=="hidraw", ATTRS{idProduct}=="3106", ATTRS{idVendor}=="2dc8", TAG+="uaccess"
      '';

      programs.gamemode.enable = true;
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };

      environment.systemPackages = with pkgs; [
        bottles
        discord
        mangohud
        prismlauncher
      ];

      environment.sessionVariables = {
        # STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
      };

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    })
  ];
}
