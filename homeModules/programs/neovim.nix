_top: {
  flake.homeModules.programs = {
    programs.neovim = {
      defaultEditor = true;
      withRuby = false;
      withPython3 = false;
    };
  };
}
