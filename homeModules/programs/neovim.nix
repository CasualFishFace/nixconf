_top: {
  flake.homeModules.programs = { config, lib, ... }: let
    inherit (config.lib.file) mkOutOfStoreSymlink;
    dotpath = "${config.home.homeDirectory}/.dotfiles";
    dotfiles = mkOutOfStoreSymlink dotpath;
  in {
    home.sessionVariables = {
      EDITOR = lib.mkDefault "nvim";
    };

    # xdg.configFile.nvim.source = "${dotfiles}/nvim";

    programs.neovim = {
      defaultEditor = true;
      withRuby = false;
      withPython3 = false;
      extraLuaConfig = ''
        dofile("${dotpath}/nvim/init.lua")
      '';
    };
  };
}
