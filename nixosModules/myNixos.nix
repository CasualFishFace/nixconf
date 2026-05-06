_top: {
  flake.nixosModules.myNixos = { lib, ... }: {
    options.myNixos = {
      bundles.graphical = {
        enable = lib.mkEnableOption ''
          Configures many options that typically come with a graphical OS installation.
        '';
      };
    };
  };
}
