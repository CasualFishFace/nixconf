{ ... }: {
  flake.wrappers.zsh = { pkgs, wlib, lib, ... }: {
      imports = [ wlib.wrapperModules.zsh ];
      zshAliases = {
        cat = lib.getExe pkgs.bat;
        ff = lib.getExe pkgs.fastfetch;
        grep = lib.getExe pkgs.ripgrep;
        md = "mkdir";
        tree = lib.getExe pkgs.tree;
      };
  };  
}
