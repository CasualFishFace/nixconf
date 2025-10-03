{ outputs, pkgs, lib, ... }: {
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

  programs.helix.settings.theme = lib.mkForce "stylix_transparent";
  programs.helix.themes.stylix_transparent = {
    inherits = "stylix";
    "ui.background" = {};
  };
}
