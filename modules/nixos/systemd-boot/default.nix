{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "nixos" "systemd-boot" ];
  output = {
    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
