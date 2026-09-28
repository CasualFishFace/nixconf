_top: {
  flake.homeModules.programs = { pkgs, ... }: {
    programs.obsidian = {
      enable = true;
      cli.enable = true;
      defaultSettings.appearance = {
        font.interface-font = pkgs.nerd-fonts.jetbrains-mono;
        font.text-font = pkgs.nerd-fonts.jetbrains-mono;
        font.monospace-font = pkgs.nerd-fonts.jetbrains-mono;
      };
    };
  };
}
