{ withSystem, ... }: {
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

      zshrc.content = /* bash */ ''
        eval "$(zoxide init --cmd cd zsh)"
      '';
  };  
}
