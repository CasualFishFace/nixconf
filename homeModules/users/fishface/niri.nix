{ inputs, ... }: {
  flake.homeModules.fishface = { pkgs, lib, ... }: let
    inherit (inputs) niri-flake noctalia;
    noctalia-exe = noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
  in {
    imports = [
      niri-flake.homeModules.niri
    ];

    programs.niri.settings = {
      spawn-at-startup = [
        (lib.getExe noctalia-exe)
      ];

      layout.gaps = 5;
      binds = {
        "Mod+Return".action.spawn-sh = lib.getExe pkgs.ghostty;
        "Mod+Q".action.close-window = {};
      };
    };
  };
}
