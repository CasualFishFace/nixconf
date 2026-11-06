{moduleWithSystem, ...}: {
  flake.wrappers.ghostty = {wlib, lib, ...}: {
    imports = [ wlib.wrapperModules.ghostty ];

    settings = {
      background-opacity = 0.7;
      font-size = 14;
      gtk-titlebar = false;
      theme = lib.mkDefault "GitHub Dark Default";
    };
  };

  flake.nixosModules.myNixos = moduleWithSystem ({self', ...}:
    {config, pkgs, lib, ...}:
    let
      noctalia-enabled = config.programs.noctalia.enable;
      extra-ghostty-config = if noctalia-enabled then
        { settings.theme = "noctalia"; }
      else
        {};
    in
    {
      options.programs.ghostty.package = lib.mkOption {
        default = pkgs.ghostty;
        type = lib.types.package;
      };
      config = {
        programs.ghostty.package = self'.packages.ghostty.wrap extra-ghostty-config;
        environment.systemPackages = [ config.programs.ghostty.package ];
      };
    }
  );
}
