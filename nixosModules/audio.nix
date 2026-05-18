_top: {
  flake.nixosModules.audio = { lib, ... }: {
    services.pipewire = {
      enable = lib.mkDefault true;
      audio.enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
    };
  };
}
