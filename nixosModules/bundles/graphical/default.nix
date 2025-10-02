{ pkgs, lib, config, ... }: {
  options.myNixos.bundles.graphical.enable = lib.mkEnableOption ''
    Enables a preset of packages I typically use with graphical NixOS installations.
  '';

  config = lib.mkIf config.myNixos.bundles.graphical.enable {
    # Theming ================================================================
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
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
