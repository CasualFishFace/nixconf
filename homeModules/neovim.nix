_top: {
  flake.homeModules.neovim = {
    programs.neovim.withRuby = false;
    programs.neovim.withPython = false;
  };
}
