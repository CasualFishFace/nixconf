{ pkgs, ... }: {
  programs.emacs = {
    package = pkgs.emacs-pgtk;
    extraConfig = ''
    '';
  };

  stylix.targets.emacs.opacity.enable = false;
}
