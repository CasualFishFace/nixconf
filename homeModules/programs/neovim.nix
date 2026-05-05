{ self, ... }: {
  flake.homeModules.programs = { pkgs, config, lib, ... }: let
    inherit (config.lib.file) mkOutOfStoreSymlink;
    inherit (pkgs.stdenv.hostPlatform) system;
    dotpath = "${config.home.homeDirectory}/.dotfiles";
    dotfiles = mkOutOfStoreSymlink dotpath;
    packages = self.packages.${system};
  in {
    home.sessionVariables = {
      EDITOR = lib.mkDefault "nvim";
    };

    home.packages = lib.mkIf config.programs.neovim.enable [ packages.nvf ];

    # xdg.configFile.nvim.source = "${dotfiles}/nvim";

    # programs.neovim = {
    #   defaultEditor = true;
    #   withRuby = false;
    #   withPython3 = false;
    #   # initLua = ''
    #   #   dofile("${dotpath}/nvim/init.lua")
    #   # '';
    # };
  };
}
