{ pkgs, lib, config, ... }: {
  options.myNixos.graphical.enable = lib.mkEnableOption ''
    Enables a preset of packages I typically use with graphical NixOS installations.
  '';

  config = lib.mkIf config.myNixos.graphical.enable {
    programs.firefox.enable = true;
    programs.hyprland.enable = true;

    security.rtkit.enable = true;
    services.pipewire.enable = true;

    environment = {
      systemPackages = with pkgs; [      
        fd
        ghostty
        git
        helix
        nil
        ripgrep
        tree
      ];
      sessionVariables = {
        EDITOR = "hx";
      };
    };
  };
}
