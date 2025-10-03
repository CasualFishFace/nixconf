# { config, lib, ... }: let
#   themes = ./../../themes;
#   selectedTheme = themes + "/${config.myHome.theme}";
#   entries = builtins.readDir selectedTheme;
#   wallpaperEntry = lib.filterAttrs (name: type:
#     (type == "regular") &&
#     (lib.hasPrefix "wallpaper." name)
#   ) entries;
#   wallpaper = builtins.head (builtins.attrNames wallpaperEntry);
# in {
#   config.services.hyprpaper.settings = lib.mkIf (config.myHome.theme != null) {
#     splash = false;
#     preload = [ "${selectedTheme}/${wallpaper}" ];
#     wallpaper = [ ", ${selectedTheme}/${wallpaper}" ];
#   };
# }
{}
