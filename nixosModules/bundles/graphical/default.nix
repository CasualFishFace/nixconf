{ pkgs, ... }: {
  programs.firefox.enable = true;
  programs.hyprland.enable = true;

  security.rtkit.enable = true;
  services.pipewire.enable = true;

  environment = {
    systemPackages = with pkgs; [      
      fd
      ghostty
      git
      helix
      nil
      ripgrep
      tree
    ];
    sessionVariables = {
      EDITOR = "hx";
    };
  };
}
