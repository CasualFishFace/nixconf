{
  flake.homeModules.default = {
    imports = [
      ./discord
      ./ghostty
      ./helix
      ./hyprland
      ./hyprshot
      ./krita
      ./waybar
      ./zoxide
    ];
  };
}
