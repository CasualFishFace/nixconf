{ pkgs, lib, config, ... }: {
  options.myNixos.bundles.graphical.enable = lib.mkEnableOption ''
    Enables a preset of packages I typically use with graphical NixOS installations.
  '';

  config = lib.mkIf config.myNixos.bundles.graphical.enable {
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
