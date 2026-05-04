_top: {
  flake.homeModules.programs = {
    home.sessionVariables = {
      EDITOR = lib.mkDefault "nvim";
    };

    programs.neovim = {
      defaultEditor = true;
      withRuby = false;
      withPython3 = false;
    };
  };
}
