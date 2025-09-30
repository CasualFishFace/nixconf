{ pkgs, config, lib, ... }: {
  options.myHome.bundles.graphical.enable = lib.mkEnableOption ''
    Enables a preset of packages someone might typically use in their graphical installation
  '';
  
  config = lib.mkIf config.myHome.bundles.graphical.enable {
    # System packages that should not be removed ==============================
    home.packages = with pkgs; [
      jetbrains-mono
    ];
    
    # General =================================================================
    programs.discord.enable = true;
    programs.firefox.enable = true;

    # Hyprland ================================================================
    wayland.windowManager.hyprland.enable = true;
    programs.hyprpanel.enable = true;
    programs.rofi.enable = true;
  };
}
