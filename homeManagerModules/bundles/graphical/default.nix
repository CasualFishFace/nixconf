{ config, lib, ... }: {
  options.myHome.bundles.graphical.enable = lib.mkEnableOption ''
    Enables a preset of packages someone might typically use in their graphical installation
  '';
  
  config = lib.mkIf config.myHome.bundles.graphical.enable {
    programs.discord.enable = true;
    programs.firefox.enable = true;
    programs.rofi.enable = true;

    wayland.windowManager.hyprland.enable = true;
  };
}
