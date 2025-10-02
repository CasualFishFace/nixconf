{ config, lib, ... }: {
  options.myHome.bundles.graphical.enable = lib.mkEnableOption ''
    Enables a preset of packages someone might typically use in their graphical installation
  '';
  
  config = lib.mkIf config.myHome.bundles.graphical.enable {
    # General =================================================================
    programs.discord.enable = true;
    programs.firefox.enable = true;
    programs.ghostty.enable = true;
    programs.helix.enable = true;

    # Hyprland ================================================================
    wayland.windowManager.hyprland.enable = true;
    services.hyprpaper.enable = true;
    programs.waybar.enable = true;
    programs.rofi.enable = true;
  };
}
