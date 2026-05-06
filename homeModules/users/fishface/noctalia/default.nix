{ inputs, ... }: {
  flake.homeModules.fishface = { pkgs, ... }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell.settings =
      (builtins.fromJSON
        (builtins.readFile ./noctalia.json)).settings;
  };
}
