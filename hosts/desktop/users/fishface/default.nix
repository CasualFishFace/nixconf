{ ... }: {
  imports = [
    ./../../../../homeManagerModules
  ];
  
  home = {
    stateVersion = "25.05";
    username = "fishface";
    homeDirectory = "/home/fishface";
    packages = [];
  };

  wayland.windowManager.hyprland.enable = true;
  programs.rofi.enable = true;
}
