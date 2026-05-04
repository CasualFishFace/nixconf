_top: {
  flake.nixosModules.cliTools = { pkgs, config, lib, ... }: {
    environment.systemPackages = with pkgs; [
        fd
        git
        neovim
        ripgrep
        tree
    ];

    environment.shellAliases = {
      find = "fd";
      grep = "rg";
      tree = "tree --dirsfirst";
      vim = "nvim";
    };
  };
}
