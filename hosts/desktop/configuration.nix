{ pkgs, inputs, ... }: {
  imports = [
    ./users
  ];

  config = {
    # Flakes and unfree packages.
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

    environment.systemPackages = [
      inputs.zen-browser.packages.x86_64-linux.specific
      pkgs.tailscale
    ];

    myNixos.bundles.graphical.enable = true;
    myNixos.specialisations.gaming.enable = true;
    myNixos.theme = "celeste/core";

    # Gaming.
    hardware.nvidia.open = true;
    services.xserver.videoDrivers = [
      "nvidia" # NVIDIA graphics card
      # "amdgpu" # AMD graphics card
    ];

    boot.kernelModules = [ "uinput" ];
    hardware.uinput.enable = true;
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };

    # Enable this for further performance increases (only if you need it)
    # hardware.nvidia.modesetting.enable = true;

    system.stateVersion = "25.05";
  };
}
