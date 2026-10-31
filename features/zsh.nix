{ withSystem, ... }: {
  flake.wrappers.zsh = { pkgs, wlib, lib, ... }: let
    withSystem' = withSystem pkgs.stdenv.hostPlatform.system;
  in {
      imports = [ wlib.wrapperModules.zsh ];
      runtimePkgs = withSystem' ({ self', ... }: [
        self'.packages.helix
      ]);

      zshAliases = {
        cat = lib.getExe pkgs.bat;
        ff = lib.getExe pkgs.fastfetch;
        grep = lib.getExe pkgs.ripgrep;
        md = "mkdir";
        tree = lib.getExe pkgs.tree;
      };

      zshrc.content = /* bash */ ''
        eval "$(${lib.getExe pkgs.zoxide} init --cmd cd zsh)"
      '';
  };  
}
