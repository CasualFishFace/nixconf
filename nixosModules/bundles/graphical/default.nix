{ myLib, ... }: {
  flake.nixosModules.default = { pkgs, config, lib, ... }: {
    options.myNixos.bundles.graphical.enable = lib.mkEnableOption ''
      Enables a preset of packages I typically use with graphical NixOS installations.
    '';

    config = lib.mkIf config.myNixos.bundles.graphical.enable {
      # Theming ================================================================
      stylix = let
        image = myLib.themes.wallpaper config.myNixos.theme;
        scheme = myLib.themes.scheme config.myNixos.theme;
      in {
        enable = true;
        polarity = "dark";
        ${if image != null then "image" else null} = image;
        ${if scheme != null then "base16Scheme" else null} = scheme;

        fonts.monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
      };
    
      fonts.fontDir.enable = true;
      fonts.fontconfig.enable = true;
      fonts.packages = with pkgs; [
        font-awesome
        nerd-fonts.jetbrains-mono
      ];

      # General ================================================================
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    
      security.rtkit.enable = true;
      services.pipewire.enable = true;

      programs.direnv.enable = true;

      environment = {
        systemPackages = with pkgs; [
          fd
          git
          nil
          pavucontrol
          ripgrep
          tree
        ];
        sessionVariables = {
          EDITOR = "hx";
        };
      };

      # Hyprland ================================================================
      programs.hyprland.enable = true;
    };
  };
}
