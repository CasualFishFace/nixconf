{ inputs, ... }: {
  flake.homeModules.fishface = { pkgs, lib, ... }: let
    inherit (inputs) niri-flake;
  in {
    imports = [
      niri-flake.homeModules.niri
    ];

    programs.niri.settings = {
      layout.gaps = 5;
      binds = {
        "Mod+Return".action.spawn-sh = lib.getExe pkgs.ghostty;
        "Mod+Q".action.close-window = null;
      };
    };
  };
}
