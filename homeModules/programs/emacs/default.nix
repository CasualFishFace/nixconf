{ pkgs, ... }: {
  programs.emacs.package = pkgs.emacs-gtk;
  programs.emacs.extraConfig = ''
  '';
}
