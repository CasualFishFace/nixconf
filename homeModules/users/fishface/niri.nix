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
      spawn-at-startup = [
        { command = [ noctalia-command ]; }
      ];

      layout.gaps = 5;
      binds = {
        "Mod+Return".action.spawn-sh = lib.getExe config.myHome.terminal;
        "Mod+D".action.spawn = if config.myHome.launcher == null
          then "${noctalia-command} ipc call launcher toggle"
          else lib.getExe config.myHome.launcher;
        "Mod+Q".action.close-window = {};
      };
    };
  };
}
