{ ... }: {
  flake.wrappers.ghostty = { wlib, ... }: {
    imports = [ wlib.wrapperModules.ghostty ];

    settings = {
      background-opacity = 0.7;
      font-size = 14;
      gtk-titlebar = false;
      theme = "Github Dark Default";
    };
  };
}
