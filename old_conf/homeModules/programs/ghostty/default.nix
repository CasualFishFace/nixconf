{ lib, ... }: {
  programs.ghostty.settings = lib.mkForce {
    background-blur = 0;
    background-opacity = 0.8;
    font-size = 12;
    theme = "stylix";
  };

  programs.ghostty.themes = {
  };
}
