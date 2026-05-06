{ self, ... }: {
  flake.homeModules.programs = { pkgs, config, lib, ... }: let
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.lib.file) mkOutOfStoreSymlink;
    dotpath = "${config.home.homeDirectory}/.dotfiles";
    dotfiles = mkOutOfStoreSymlink dotpath;
    packages = self.packages.${system};
  in {
    options.programs.nvf.enable = lib.mkEnableOption ''
      Enables my NVF package found in `flake.packages`.
    '';

    config = {
      home.packages = lib.mkIf config.programs.nvf.enable [ packages.nvf ];
      home.sessionVariables = {
        EDITOR = lib.mkDefault "nvim";
      };

      xdg.configFile.nvim.source = "${dotfiles}/nvim";

      # programs.neovim = {
      #   defaultEditor = true;
      #   withRuby = false;
      #   withPython3 = false;
      #   initLua = ''
      #     dofile("${dotpath}/nvim/init.lua")
      #   '';
      # };
    };
  };
}
