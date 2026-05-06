{ inputs, self, ... }: {
  flake.homeModules.fishface = { pkgs, ... }: let
    inherit (pkgs.stdenv.hostPlatform) system;
    noctalia = inputs.noctalia.packages.${system}.default;
  in {
    imports = [
      self.homeModules.myHome
      self.homeModules.programs
    ];

    programs.home-manager.enable = true;

    myHome.launcher = pkgs.fuzzel;
    myHome.statusBar = noctalia;
    myHome.terminal = pkgs.ghostty;

    home = {
      stateVersion = "25.05";
      username = "fishface";
      homeDirectory = "/home/fishface";
      packages = [
        (pkgs.writeShellScriptBin "startgaming" ''
          sudo /run/current-system/specialisation/gaming/bin/switch-to-configuration switch
        '')
      ];
    
      pointerCursor = {
        enable = true;
        size = 96;
    
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
    
        hyprcursor.enable = true;
        hyprcursor.size = 96;
      };
    };
    
    programs.bash.enable = true;
    programs.bazaar.enable = true;
    programs.discord.enable = true;
    programs.firefox.enable = true;
    programs.fuzzel.enable = true;
    programs.ghostty.enable = true;
    programs.hyprshot.enable = true;
    programs.niri.enable = true;
    programs.nvf.enable = true;
    programs.quickshell.enable = true;
    programs.waybar.enable = true;
    programs.zoxide.enable = true;
    
    services.hyprpaper.enable = true;
    
    wayland.windowManager.hyprland.enable = true;
  };
}
