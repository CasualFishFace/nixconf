{ config, ... }: {
  stylix.targets.waybar.enable = false;
  
  programs.waybar.style = let
    unprocessed = builtins.readFile ./style.css;
    inherit (config.lib.stylix) colors;
    names = builtins.map (x: "--${x}") [
      "bg0" "bg1"
      "fg0"
      "border0"
      "inactive" "active" "urgent"
    ];
    values = with colors.withHashtag; [
      base00 base01
      base05
      base05
      base03 base0D base08
    ];
  in builtins.replaceStrings names values unprocessed;

  programs.waybar.settings = let
    withModules = import ./withModules.nix config.lib.stylix.colors;
  in {
    desktop = withModules {
      layer = "top";
      position = "top";
      height = 24;
      output = [ "DVI-D-1" "HDMI-A-1" ];
      margin-top = 5;
      modules-left = [ "group/power" "tray" "hyprland/window" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [ "bluetooth" "network" "clock" "group/usage" ];
    };

    laptop = withModules {
      layer = "top";
      position = "top";
      height = 24;
      output = [ "eDP-1" ];
      margin-top = 5;
      modules-left = [ "group/power" "tray" "hyprland/window" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [ "bluetooth" "network" "clock" "battery" "group/usage" ];
    };
  };
}
