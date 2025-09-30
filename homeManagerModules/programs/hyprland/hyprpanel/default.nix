{
  programs.hyprpanel.settings = {
    layout = {
      bar.layouts = {
        "*" = {
          left = [ "dashboard" "workspaces" ];
          middle = [];
          right = [ "volume" "network" "bluetooth" "clock" "notifications" ];
        };
        "0".extends = "*";
        "1".extends = "*";
      };
    };

    bar.launcher.autoDetectIcon = true;
    bar.workspaces.show_icons = true;

    bar.clock.format = "%a %d | %H:%M";

    menus.clock = {
      time.military = true;
      time.hideSeconds = true;
      weather.unit = "metric";
    };

    menus.dashboard = {
      directories.enabled = false;
      stats.enable_gpu = true;
    };

    theme.bar.transparent = true;
    theme.bar.font = {
      name = "JetBrainsMono Nerd Font";
      size = "16px";
    };
  };
}
