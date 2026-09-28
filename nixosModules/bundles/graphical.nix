# This is a bundle because it pulls many single-responsibility / small-scope modules to form a
# larger part of a configuration. Bundles also have sensible defaults that can be changed without
# much thought.

{ self, ... }: {
  flake.nixosModules.bundles = { config, lib, ... }: {
    imports = [
      self.nixosModules.audio
      self.nixosModules.terminal
      self.nixosModules.displayManagers
      self.nixosModules.essential
      self.nixosModules.fonts
      self.nixosModules.myNixos
      self.nixosModules.programs
      self.nixosModules.specialisations
      self.nixosModules.windowManagers
    ];

    config = let
      inherit (config.myNixos) bundles;
    in lib.mkIf bundles.graphical.enable {
      nixpkgs.config.permittedInsecurePackages = [
        "electron-38.8.4"
      ];

      hardware.opentabletdriver = {
        enable = true;
        daemon.enable = true;
      };

      security.rtkit.enable = lib.mkDefault true;

      services.displayManager.gdm.enable = lib.mkDefault true;
      services.flatpak.enable = lib.mkDefault true;
      services.fwupd.enable = lib.mkDefault true;
      services.geoclue2.enable = lib.mkDefault true;
      services.localtimed.enable = lib.mkDefault true;
      services.xserver.enable = lib.mkDefault true;

      programs.bash.enable = lib.mkDefault true;
      programs.firefox.enable = lib.mkDefault true;
      programs.hyprland.enable = lib.mkDefault true;
      programs.niri.enable = lib.mkDefault true;
      programs.xwayland.enable = lib.mkDefault true;
    };
  };
}
