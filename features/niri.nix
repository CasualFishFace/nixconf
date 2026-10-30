{ ... }: {
  flake.wrappers.niri = { pkgs, wlib, lib, ... }: let
    terminal = pkgs.ghostty;
  in {
    imports = [ wlib.wrapperModules.niri ];
    settings = {
      binds = {
        "Mod+Q".action.close-window = {};
        "Mod+Return".action.spawn-sh = lib.getExe terminal;
        # "Mod+D".action.spawn-sh = if config.myHome.statusBar == noctalia-exe
        #   then "${noctalia-command} ipc call launcher toggle"
        #   else lib.getExe config.myHome.launcher;
        "Mod+D".action.spawn-sh = lib.getExe pkgs.fuzzel;

        "Mod+H".action.focus-column-or-monitor-left = {};
        "Mod+L".action.focus-column-or-monitor-right = {};
        "Mod+J".action.focus-window-or-workspace-down = {};
        "Mod+K".action.focus-window-or-workspace-up = {};
        "Mod+Ctrl+H".action.focus-monitor-left = {};
        "Mod+Ctrl+L".action.focus-monitor-right = {};

        "Mod+Shift+H".action.move-column-left-or-to-monitor-left = {};
        "Mod+Shift+L".action.move-column-right-or-to-monitor-right = {};
        "Mod+Shift+J".action.move-window-down-or-to-workspace-down = {};
        "Mod+Shift+K".action.move-window-up-or-to-workspace-up = {};
        "Mod+Shift+Ctrl+H".action.move-window-to-monitor-left = {};
        "Mod+Shift+Ctrl+L".action.move-window-to-monitor-right = {};

        "Mod+Space".action.switch-focus-between-floating-and-tiling = {};
        "Mod+Shift+Space".action.toggle-window-floating = {};

        "Mod+R".action.switch-preset-column-width = {};
        "Mod+F".action.maximize-column = {};
        "Mod+Shift+F".action.fullscreen-window = {};

        "Mod+O".action.toggle-overview = {};

        "Print".action.screenshot = {};
        "Mod+Print".action.screenshot-window = {};
        "Mod+Ctrl+Print".action.screenshot-screen = {};

        # "Mod+V".action.spawn-sh = "${noctalia-command} ipc call plugin:clipboard toggle";
      };

      gestures.hot-corners.enable = false;

      hotkey-overlay = {
        hide-not-bound = true;
        skip-at-startup = true;
      };

      input = {
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };
      };

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
        insert-hint.enable = false;

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

      window-rules = [{
        geometry-corner-radius = {
          top-left = 12.0;
          top-right = 12.0;
          bottom-right = 12.0;
          bottom-left = 12.0;
        };

        clip-to-geometry = true;
      }];

      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
    };
  };
}
