{ self, ... }: {
  flake.homeModules.fishface = { pkgs, ... }: {
    imports = [
      self.homeModules.programs
    ];

    programs.home-manager.enable = true;

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
    
    programs.discord.enable = true;
    programs.firefox.enable = true;
    programs.fuzzel.enable = true;
    programs.ghostty.enable = true;
    programs.hyprshot.enable = true;
    # programs.krita.enable = true;
    programs.neovim.enable = true;
    programs.quickshell.enable = true;
    programs.waybar.enable = true;
    programs.zoxide.enable = true;
    
    services.hyprpaper.enable = true;
    
    wayland.windowManager.hyprland.enable = true;
  };
}
