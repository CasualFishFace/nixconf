{moduleWithSystem, ...}: {
  flake.wrappers.helix = {pkgs, wlib, lib, ...}: {
    imports = [ wlib.wrapperModules.helix ];

    runtimePkgs = [ pkgs.nixd pkgs.nixdoc ];

    languages = {};

    settings = {
      editor = {
        bufferline = "always";
        color-modes = true;
        cursorline = true;
        indent-heuristic = "hybrid";
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "error";
        };
        # jump-label-alphabet = "1234567890";
        line-number = "relative";
        mouse = false;
        rulers = [ 80 ];
      };

      theme = lib.mkDefault "custom";
    };

    themes.custom = {
      inherits = "github_dark";
      "ui.background" = "transparent";
    };
  };

  flake.nixosModules.myNixos = moduleWithSystem ({self', ...}:
    {config, pkgs, lib, ...}: {
      options.programs.helix = {
        enable = lib.mkEnableOption "Enables Helix, the modal text editor";
        package = lib.mkOption {
          default = pkgs.helix;
          type = lib.types.package;
        };
      };
      config = {
        programs.helix.enable = lib.mkDefault true;
        programs.helix.package = lib.mkDefault self'.packages.helix;
        environment.systemPackages = lib.mkIf config.programs.helix.enable [
          config.programs.helix.package
        ];
      };
    }
  );
}
