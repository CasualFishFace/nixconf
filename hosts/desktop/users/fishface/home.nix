{ ... }: {
  programs.home-manager.enable = true;
  home = {
    stateVersion = "25.05";
    username = "fishface";
    homeDirectory = "/home/fishface";
    packages = [];
  };
}
