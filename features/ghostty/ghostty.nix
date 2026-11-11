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
    {
      options.programs.ghostty = {
        enable = lib.mkEnableOption "Enables Ghostty, a terminal emulator written in Zig";
        package = lib.mkOption {
          default = pkgs.ghostty;
          type = lib.types.package;
        };
      };
      config = {
        programs.ghostty.enable = lib.mkDefault true;
        programs.ghostty.package = lib.mkDefault self'.packages.ghostty;
        environment.systemPackages = lib.mkIf config.programs.ghostty.enable [
          config.programs.ghostty.package
        ];
      };
    }
  );
}
