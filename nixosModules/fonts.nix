_top: {
  flake.nixosModules.fonts = { pkgs, ... }: {
    fonts.fontDir.enable = true;
    fonts.fontconfig.enable = true;
    fonts.packages = with pkgs; [
      corefonts
      dina-font
      fira-code
      fira-code-symbols
      font-awesome
      mplus-outline-fonts.githubRelease
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      proggyfonts
    ];
  };
}
