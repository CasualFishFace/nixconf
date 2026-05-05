{ inputs, self, ... }: {
  perSystem = { pkgs, ... }: let
    inherit (inputs) nvf;
  in {
    packages.nvf = (nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ self.nvfModules.config ];
    }).neovim;
  };

  flake.nvfModules.config = {
    vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };

      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;

      opts = {
        cursorline = true;
        expandtab = true;
        mouse = "";
        number = true;
        relativenumber = true;
        shiftwidth = 4;
        tabstop = 4;
        termguicolors = true;
      };

      languages = {
        enableLSP = true;
        enableTreesitter = true;

        nix.enable = true;
        rust.enable = true;
        zig.enable = true;
      };
    };
  };
}
