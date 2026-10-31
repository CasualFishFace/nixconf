{ ... }: {
  flake.wrappers.niri = { pkgs, wlib, lib, ... }: let
    terminal = pkgs.ghostty;
  in {
    imports = [ wlib.wrapperModules.niri ];
    settings = {
      binds = {
        "Mod+Q".close-window = _: {};
        "Mod+Return".spawn-sh = lib.getExe terminal;
        # "Mod+D".spawn-sh = if config.myHome.statusBar == noctalia-exe
        #   then "${noctalia-command} ipc call launcher toggle"
        #   else lib.getExe config.myHome.launcher;
        "Mod+D".spawn-sh = lib.getExe pkgs.fuzzel;

        "Mod+H".focus-column-or-monitor-left = _: {};
        "Mod+L".focus-column-or-monitor-right = _: {};
        "Mod+J".focus-window-or-workspace-down = _: {};
        "Mod+K".focus-window-or-workspace-up = _: {};
        "Mod+Ctrl+H".focus-monitor-left = _: {};
        "Mod+Ctrl+L".focus-monitor-right = _: {};

        "Mod+Shift+H".move-column-left-or-to-monitor-left = _: {};
        "Mod+Shift+L".move-column-right-or-to-monitor-right = _: {};
        "Mod+Shift+J".move-window-down-or-to-workspace-down = _: {};
        "Mod+Shift+K".move-window-up-or-to-workspace-up = _: {};
        "Mod+Shift+Ctrl+H".move-window-to-monitor-left = _: {};
        "Mod+Shift+Ctrl+L".move-window-to-monitor-right = _: {};

        "Mod+Space".switch-focus-between-floating-and-tiling = _: {};
        "Mod+Shift+Space".toggle-window-floating = _: {};

        "Mod+R".switch-preset-column-width = _: {};
        "Mod+F".maximize-column = _: {};
        "Mod+Shift+F".fullscreen-window = _: {};

        "Mod+O".toggle-overview = _: {};

        # "Print".screenshot = {};
        # "Mod+Print".screenshot-window = {};
        # "Mod+Ctrl+Print".screenshot-screen = {};

        # "Mod+V".spawn-sh = "${noctalia-command} ipc call plugin:clipboard toggle";
      };

      # gestures.hot-corners.enable = false;

      hotkey-overlay = {
        hide-not-bound = true;
        skip-at-startup = true;
      };

      # input = {
      #   focus-follows-mouse = {
      #     enable = true;
      #     max-scroll-amount = "0%";
      #   };
      # };

      layer-rules = [
        {
          block-out-from = "screen-capture";
          matches = [
            { namespace = "^notifications$"; }
          ];
        }
      ];

      layout = {
        always-center-single-column = true;
        center-focused-column = "never";
        default-column-display = "tabbed";
        default-column-width.proportion = 1.0;
        empty-workspace-above-first = true;
        focus-ring.width = 2;
        gaps = 5;
        # insert-hint.enable = false;

        preset-column-widths = map (proportion: { inherit proportion; }) [
          0.33333
          0.5
          0.66667
        ];

        struts = lib.mergeAttrsList
          (map (name: { ${name} = 5; }) [ "left" "right" "top" "bottom" ]);

        tab-indicator.hide-when-single-tab = true;
      };

      outputs = {
        "DVI-D-1" = {};
        "HDMI-A-1" = {};
      };

      prefer-no-csd = true;

      spawn-at-startup = [
        (lib.getExe terminal)
      ];

      # window-rules = [{
      #   geometry-corner-radius = {
      #     top-left = 12.0;
      #     top-right = 12.0;
      #     bottom-right = 12.0;
      #     bottom-left = 12.0;
      #   };

      #   clip-to-geometry = true;
      # }];

      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
    };
  };
}
