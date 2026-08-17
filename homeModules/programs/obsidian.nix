_top: {
  flake.homeModules.programs = _args: {
    programs.obsidian = {
      enable = true;
      cli.enable = true;
    };
  };
}
