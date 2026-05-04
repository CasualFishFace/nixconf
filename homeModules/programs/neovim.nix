_top: {
  flake.homeModules.programs = { lib, ... }: {
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
