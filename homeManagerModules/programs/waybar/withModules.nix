colors: extraConfig: extraConfig // {
  "custom/info" = {
    format = " 󰋽 ";
    tooltip = false;
    # on-click = "ghostty -e \"nix-shell -p neofetch --run neofetch\"";
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

  battery = let
    urgent = colors.withHashtag.base08;
    low-battery = colors.withHashtag.base0D;
  in {
    format-10 = "<span style=\"color: ${urgent}\">󰁺 {capacity}%</span>";
    format-20 = "<span style=\"color: ${low-battery}\">󰁻 {capacity}%</span>";
    format-30 = "󰁼 {capacity}%";
    format-40 = "󰁽 {capacity}%";
    format-50 = "󰁾 {capacity}%";
    format-60 = "󰁿 {capacity}%";
    format-70 = "󰂀 {capacity}%";
    format-80 = "󰂁 {capacity}%";
    format-90 = "󰂂 {capacity}%";
    format-100 = "󰁹 {capacity}%";
    format-charging-10 = "󰢜 {capacity}%";
    format-charging-20 = "󰂆 {capacity}%";
    format-charging-30 = "󰂇 {capacity}%";
    format-charging-40 = "󰂈 {capacity}%";
    format-charging-50 = "󰢝 {capacity}%";
    format-charging-60 = "󰂉 {capacity}%";
    format-charging-70 = "󰢞 {capacity}%";
    format-charging-80 = "󰂊 {capacity}%";
    format-charging-90 = "󰂋 {capacity}%";
    format-charging-100 = "󰂅 {capacity}%";
    states = {
      "10" = 10;
      "20" = 20;
      "30" = 30;
      "40" = 40;
      "50" = 50;
      "60" = 60;
      "70" = 70;
      "80" = 80;
      "90" = 90;
      "100" = 100;
    };
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
