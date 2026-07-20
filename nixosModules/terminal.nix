{ self, ... }: {
  flake.nixosModules.terminal = { pkgs, ... }: let
    myPkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    environment.systemPackages = with pkgs; [
        fd
        nixd
        ripgrep
        tree
    ] ++ (with myPkgs; [
      git
      helix
    ]);

    environment.shellAliases = {
      find = "fd";
      grep = "rg";
      tree = "tree --dirsfirst";
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
    };
  };
}
