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

  programs.waybar.settings = {
    main = {
      layer = "top";
      position = "top";
      height = 24;
      output = [ "DVI-D-1" "HDMI-A-1" ];
      modules-left = [ "tray" "hyprland/window" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [ "cpu" "memory" "network" "bluetooth" "clock" ];

      "hyprland/window" = {
        format = "{title}";
        rewrite = {};
        separate-outputs = true;
        icon = true;
        icon-size = 16;
      };

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons.default = "-";
        format-icons.active = "+";
        format-icons.urgent = "!";
        on-scroll-up = "hyprctl distpatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        on-click = "activate";
      };

      bluetooth = {
        format = "󰂯 {status}";
        format-connected = "󰂯 ";
        format-disabled = "󰂲 ";
        format-no-controller = "";
      };

      clock = {
        format = " {:%a %d  %H:%M}";
        tooltip = false;
      };

      cpu = {
        format = " {usage}%";
        tooltip = false;
      };

      memory = {
        format = "󰍛 {used}/{total}";
        tooltip = false;
      };

      network = {
        format-ethernet = " {ipaddr}/{cidr}";
        format-wifi = " {icon}";
        format-disconnected = "";
        format-icons = [ "󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 " ];
        tooltip-format-wifi = "{essid} ({signalStrength}%)";
        tooltip-format-ethernet = "{ifname}";
        tooltip-format-disconnected = "Disconnected";
      };

      tray = {
        icon-size = 16;
        show-passive-items = false;
        spacing = 5;
        reverse-direction = false;
      };
    };
  };
}
