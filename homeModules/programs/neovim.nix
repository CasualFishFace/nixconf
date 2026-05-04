_top: {
  flake.homeModules.programs = { config, lib, ... }: let
    inherit (config.lib.file) mkOutOfStoreSymlink;
    dotfiles = mkOutOfStoreSymlink "${config.xdg.configHome}/.dotfiles";
  in {
    home.sessionVariables = {
      EDITOR = lib.mkDefault "nvim";
    };

    programs.neovim = {
      defaultEditor = true;
      withRuby = false;
      withPython3 = false;
    };

    xdg.configFile.nvim.source = "${dotfiles}/nvim";
  };
}
