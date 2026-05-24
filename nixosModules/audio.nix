_top: {
  flake.nixosModules.audio = { lib, ... }: {
    services.pipewire = {
      enable = lib.mkDefault true;
      alsa.enable = true;
      alsa.support32Bit = true;
      audio.enable = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
