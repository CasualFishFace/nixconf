{ pkgs, config, myLib, lib, ... }: {
  options.myHome.bundles.graphical.enable = lib.mkEnableOption ''
    Enables a preset of packages someone might typically use in their graphical installation
  '';
  
  config = lib.mkIf config.myHome.bundles.graphical.enable {
    # Theming =================================================================
    home.pointerCursor = {
      enable = true;
      size = 96;

      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";

      hyprcursor.enable = true;
      hyprcursor.size = 96;
    };
    
    stylix = myLib.stylixConfig {
      fonts.monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
    };
    
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
