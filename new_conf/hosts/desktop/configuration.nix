{
  home-manager.users = {
    fishface = ./fishface;
  };

  users.users = {
    fishface = {
      isNormalUser = true;
      description = "CasualFishFace";
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
      ];
      packages = [ ];
    };
  };
  
  # Flakes, experimental features, overlays.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "fishface" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];

  # Networking
  networking.hostName = "desktop"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Time Zone
  time.timeZone = "America/Chicago";

  # Internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  system.stateVersion = "25.05";
}
