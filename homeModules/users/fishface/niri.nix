{ inputs, ... }: {
  flake.homeModules.fishface = { pkgs, config, lib, ... }: let
    inherit (inputs) niri-flake noctalia;
    noctalia-exe = noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    noctalia-command = lib.getExe noctalia-exe;
  in {
    imports = [
      niri-flake.homeModules.niri
    ];

    programs.niri.settings = {
      binds = {
        "Mod+Q".action.close-window = {};
        "Mod+Return".action.spawn-sh = lib.getExe config.myHome.terminal;
        "Mod+D".action.spawn-sh = if config.myHome.statusBar == noctalia-exe
          then "${noctalia-command} ipc call launcher toggle"
          else lib.getExe config.myHome.launcher;

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

        "Mod+F".action.maximize-column = {};
        "Mod+Shift+F".action.fullscreen-window = {};

        "Mod+O".action.toggle-overview = {};

        "Print".action.screenshot = {};
        "Mod+Print".action.screenshot-window = {};
        "Mod+Ctrl+Print".action.screenshot-screen = {};

        "Mod+Ctrl+Shift+M".action.do-screen-transition = {};
      };

      layout = {
        always-center-single-column = true;
        center-focused-column = "never";
        default-column-display = "tabbed";
        default-column-width.proportion = 0.5;
        empty-workspace-above-first = true;
        focus-ring.width = 2;
        gaps = 5;
        insert-hint.enable = false;

        preset-column-widths = builtins.map (proportion: { inherit proportion; }) [
          0.33333
          0.5
          0.66667
        ];

        struts = lib.mergeAttrsList
          (builtins.map (name: { ${name} = 5; }) [ "left" "right" "top" "bottom" ]);

        tab-indicator.hide-when-single-tab = true;
      };

      prefer-no-csd = true;

      spawn-at-startup = [
        { command = [ noctalia-command ]; }
      ];
    };
  };
}
