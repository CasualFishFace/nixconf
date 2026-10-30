{ ... }: {
  flake.wrappers.ghostty = { wlib, ... }: {
    imports = [ wlib.wrapperModules.ghostty ];

    settings = {
      background-opacity = 0.7;
      gtk-titlebar = false;
      theme = "GitHub Dark Default";
    };
  };
}
