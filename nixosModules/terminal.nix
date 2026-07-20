{ self, ... }: {
  flake.nixosModules.terminal = { pkgs, lib, ... }: let
    myPkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    environment = {
      sessionVariables = {
        "EDITOR" = lib.getExe myPkgs.helix;
      };
      shellAliases = {
        find = "fd";
        grep = "rg";
        tree = "tree --dirsfirst";
      };
      systemPackages = with pkgs; [
          fd
          nixd
          ripgrep
          tree
      ] ++ (with myPkgs; [
        git
        helix
      ]);
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      flags = [ "--cmd cd" ];
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableLsColors = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [];
        theme = "simple";
      };
    };

    users.defaultUserShell = pkgs.zsh;
  };
}
