# This is a bundle because it pulls many single-responsibility / small-scope modules to form a
# larger part of a configuration. Bundles also have sensible defaults that can be changed without
# much thought.

{ self, ... }: {
  flake.nixosModules.bundles = { pkgs, config, lib, ... }: {
    imports = [
      self.nixosModules.cliTools
      self.nixosModules.displayManagers
      self.nixosModules.essential
      self.nixosModules.fonts
      self.nixosModules.programs
      self.nixosModules.specialisations
      self.nixosModules.users
      self.nixosModules.windowManagers
    ];

    options.myNixos.bundles.graphical = {
      enable = lib.mkEnableOption ''
        Configures many options that typically come with a graphical OS installation.
      '';
    };

    config = let
      inherit (config.myNixos) bundles;
    in lib.mkIf bundles.graphical.enable {
      security.rtkit.enable = lib.mkDefault true;
      services.displayManager.gdm.enable = lib.mkDefault true;
      services.flatpak.enable = lib.mkDefault true;
      services.fwupd.enable = lib.mkDefault true;
      services.pipewire.enable = lib.mkDefault true;
      programs.hyprland.enable = lib.mkDefault true;
      programs.firefox.enable = lib.mkDefault true;
      programs.ghostty.enable = lib.mkDefault true;
      programs.discord.enable = lib.mkDefault true;
    };
  };
}
