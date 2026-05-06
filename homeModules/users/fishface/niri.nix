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

        "Mod+H".action.focus-window-or-column-left = {};
        "Mod+L".action.focus-window-or-column-right = {};
        "Mod+J".action.focus-window-or-workspace-down = {};
        "Mod+K".action.focus-window-or-workspace-up = {};
      };

      layout = {
        always-center-single-column = true;
        center-focused-column = "never";
        default-column-display = "tabbed";
        default-column-width.proportion = 0.5;
        empty-workspace-above-first = true;
        focus-ring.width = 2;
        gaps = 5;
        insert-hint.off = true;

        preset-column-widths = builtins.map (proportion: { inherit proportion; }) [
          0.33333
          0.5
          0.66667
        ];

        struts = builtins.map (name: { ${name} = 5; }) [ "left" "right" "top" "bottom" ];
        tab-indicator.hide-when-single-tab = true;
      };

      prefer-no-csd = true;

      spawn-at-startup = [
        { command = [ noctalia-command ]; }
      ];
    };
  };
}
