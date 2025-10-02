{ pkgs, config, myLib, lib, ... }: {
  options.myHome.bundles.graphical.enable = lib.mkEnableOption ''
    Enables a preset of packages someone might typically use in their graphical installation
  '';
  
  config = let
    themesDirectory = ./../../themes;
    selectedTheme = "${themesDirectory}/${config.myHome.theme}";
    wallpaper = myLib.themeWallpaper selectedTheme;
  in lib.mkIf config.myHome.bundles.graphical.enable {
    # Theming =================================================================
    home.pointerCursor = {
      enable = true;
      size = 96;

      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";

      hyprcursor.enable = true;
      hyprcursor.size = 96;
    };
    
    stylix = {
      enable = true;
      image = wallpaper;
      polarity = "dark";
      base16Scheme = lib.mkIf (config.myHome.theme != null)
        "${selectedTheme}/scheme.yaml";

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
