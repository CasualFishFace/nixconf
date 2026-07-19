{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.ghostty = (inputs.wrappers.wrapperModules.ghostty.apply {
      inherit pkgs;
      
      settings = {
        background-opacity = 0.7;
        gtk-titlebar = false;
        theme = "GitHub Dark Default";
      };
    }).wrapper;
  };
}
