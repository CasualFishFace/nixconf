{ config, lib, ... }: let
  themes = ./../../themes;
  selectedTheme = themes + "/${config.myHome.theme}";
  entries = builtins.readDir selectedTheme;
  wallpaper = builtins.head (lib.filterAttrs (name: type:
    (type == "regular") &&
    (lib.hasPrefix "wallpaper." name)
  ) entries);
in {
  config.services.hyprpaper.settings = lib.mkIf (config.myHome.theme != null) {
    splash = false;
    preload = [ wallpaper ];
    wallpaper = [ ", ${wallpaper}" ];
  };
}
