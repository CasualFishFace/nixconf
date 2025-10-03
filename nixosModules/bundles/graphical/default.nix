{ pkgs, myLib, lib, config, ... }: {
  options.myNixos.bundles.graphical.enable = lib.mkEnableOption ''
    Enables a preset of packages I typically use with graphical NixOS installations.
  '';

  config = lib.mkIf config.myNixos.bundles.graphical.enable {
    # Theming ================================================================
    stylix = myLib.stylixConfig {
      themeName = "balatro";

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
    security.rtkit.enable = true;
    services.pipewire.enable = true;

    environment = {
      systemPackages = with pkgs; [
        fd
        git
        nil
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
}
