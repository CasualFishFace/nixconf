{ ... }: {
  flake.nixosModules.default = { pkgs, config, lib, ... }: {
    options.myNixos.bundles.niri.enable = lib.mkEnableOption ''
      Enables niri and some extra packages for a smooth experience.
    '';

    config = lib.mkIf config.myNixos.bundles.niri.enable {
      programs.niri.enable = true;
      programs.xwayland.enable = true;
      environment.systemPackages = [ pkgs.xwayland-satellite ];
    };
  };
}
