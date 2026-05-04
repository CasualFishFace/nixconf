{ pkgs, ... }: {
  programs.emacs = {
    package = pkgs.emacs-pgtk;
    extraConfig = ''
    '';
  };

  stylix.targets.emacs = {
    fonts.enable = false;
    opacity.enable = false;
  };
}
