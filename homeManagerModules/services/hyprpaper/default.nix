{ config, lib, ... }: let
  themes = ./../../themes;
  selectedTheme = "${themes}/${config.myHome.theme}";
in {
  config.services.hyprpaper.settings = lib.mkIf (config.myHome.theme != null) {
    splash = false;
    preload = [ selectedTheme ];
    wallpaper = [
      ", ${selectedTheme}"
    ];
  };
}
