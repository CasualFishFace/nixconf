_top: {
  flake.homeModules.neovim = {
    programs.neovim.withRuby = false;
    programs.neovim.withPython3 = false;
  };
}
