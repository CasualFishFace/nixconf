{ outputs, pkgs, ... }: {
  imports = [
    outputs.homeManagerModules.default
  ];
  
  home = {
    stateVersion = "25.05";
    username = "fishface";
    homeDirectory = "/home/fishface";
    packages = [
      (pkgs.writeShellScriptBin "startgaming" ''
        sudo /run/current-system/specialisation/gaming/bin/switch-to-configuration switch
      '')
    ];
  };

  myHome.bundles.graphical.enable = true;
  stylix.targets.firefox.profileNames = [ "fishface" ];
}
