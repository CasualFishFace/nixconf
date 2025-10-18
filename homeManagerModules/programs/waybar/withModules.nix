extraConfig: extraConfig // {
  "custom/info" = {
    format = " 󰋽 ";
    tooltip = false;
  };

  "custom/power-off" = {
    format = " ⏻ ";
    tooltip = false;
    on-click = "shutdown now";
  };

  "custom/restart" = {
    format = "  ";
    tooltip = false;
    on-click = "shutdown -r now";
  };

  "custom/logout" = {
    format = " 󰗽 ";
    tooltip = false;
    on-click = "hyprctl dispatch exit";
  };

  "group/power" = {
    orientation = "inherit";
    modules = [ "custom/power-off" "custom/restart" "custom/logout" ];
    drawer.transition-duration = 200;
    drawer.transition-left-to-right = true;
    drawer.click-to-reveal = false;
  };

  "group/usage" = {
    orientation = "inherit";
    modules = [ "custom/info" "cpu" "memory" ];
    drawer.transition-duration = 200;
    drawer.transition-left-to-right = false;
    drawer.click-to-reveal = false;
  };

  "hyprland/window" = {
    format = "{title}";
    rewrite = {
      "title<(\\s*)(.*)(\\s*)>" = "$2";
    };
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
    format = " {used}/{total}";
    tooltip = false;
  };

  network = {
    format-ethernet = " {ipaddr}/{cidr}";
    format-wifi = "{icon}Connected";
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
}
