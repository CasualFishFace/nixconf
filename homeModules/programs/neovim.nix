_top: {
  flake.homeModules.programs = { config, lib, ... }: let
    inherit (config.lib.file) mkOutOfStoreSymlink;
    dotfiles = mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles";
  in {
    home.sessionVariables = {
      EDITOR = lib.mkDefault "nvim";
    };

    programs.neovim = {
      defaultEditor = true;
      withRuby = false;
      withPython3 = false;
    };

    home.file.nvim.source = "${dotfiles}/nvim";
  };
}
