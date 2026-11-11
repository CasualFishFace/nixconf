{ ... }: {
  flake.nixosModules.nvidia = { ... }: {
    boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];

    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
