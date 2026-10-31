{ moduleWithSystem, withSystem, ... }: {
  flake.wrappers.zsh = { pkgs, wlib, lib, ... }: let
    withSystem' = withSystem pkgs.stdenv.hostPlatform.system;
  in {
      imports = [ wlib.wrapperModules.zsh ];
      runtimePkgs = withSystem' ({ self', ... }: [
        self'.packages.git
        self'.packages.helix
        pkgs.zoxide
      ]);

      zshAliases = {
        cat = lib.getExe pkgs.bat;
        ff = lib.getExe pkgs.fastfetch;
        grep = lib.getExe pkgs.ripgrep;
        md = "mkdir";
        tree = lib.getExe pkgs.tree;
      };

      zlogin.content = /* bash */ ''
        echo "zsh"
      '';

      zshrc.content = /* bash */ ''
        eval "$(zoxide init --cmd cd zsh)"
      '';
  };  

  flake.nixosModules.zsh = moduleWithSystem ({ self', ... }: {
    programs.zsh = {
      enable = true;
      package = self'.packages.zsh;
      enableCompletion = true;
      enableLsColors = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [];
        theme = "simple";
      };
    };
  });
}
