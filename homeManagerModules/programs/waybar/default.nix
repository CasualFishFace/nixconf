{
  programs.waybar.style = builtins.readFile ./style.css;
  programs.waybar.settings = {
    main = {
      layer = "top";
      position = "top";
      height = 24;
      output = [ "DVI-D-1" "HDMI-A-1" ];
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ ];
      modules-right = [ "network" "bluetooth" "clock" ];
    };
  };
}
