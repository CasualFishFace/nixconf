{ inputs, ... }: {
  flake.homeModules.fishface = { pkgs, lib, ... }: let
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
        "Mod+Return".action.spawn-sh = lib.getExe pkgs.ghostty;
        "Mod+Q".action.close-window = {};
      };
    };
  };
}
