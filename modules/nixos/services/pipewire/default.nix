{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "nixos" "services" "pipewire" ];
  output = {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
}
