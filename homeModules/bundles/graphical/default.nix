{ myLib, pkgs, config, lib, ... }: {
  # flake.homeModules.default = {
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
    
      stylix.enable = true;
    
      # General =================================================================
      programs.bash.enable = true;
      programs.discord.enable = true;
      # programs.firefox.enable = true;
      programs.ghostty.enable = true;
      programs.helix.enable = true;
      programs.krita.enable = true;
      programs.zoxide.enable = true;

      # Hyprland ================================================================
      wayland.windowManager.hyprland.enable = true;
      services.hyprpaper = let
        theme = config.myHome.theme or config.myNixos.theme;
      in {
        enable = true;
        settings.preload = lib.mkIf (theme != null) [
          ",${myLib.themes.wallpaper theme}"
        ];
      };

      programs.hyprshot.enable = true;
      programs.waybar.enable = true;
      programs.fuzzel.enable = true;
    };
  # };
}
