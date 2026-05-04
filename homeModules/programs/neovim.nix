_top: {
  flake.homeModules.programs = { config, lib, ... }: let
    inherit (config.lib.file) mkOutOfStoreSymlink;
    dotfiles = "${config.home.homeDirectory}/.dotfiles";
  in {
    home.sessionVariables = {
      EDITOR = lib.mkDefault "nvim";
    };

    programs.neovim = {
      defaultEditor = true;
      withRuby = false;
      withPython3 = false;
      initLua = builtins.readFile (mkOutOfStoreSymlink "${dotfiles}/nvim/init.lua");
    };
  };
}
