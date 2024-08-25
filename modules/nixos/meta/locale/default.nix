{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "nixos" "meta" "locale" ];
  default = true;
  output = {
    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";
    console.keyMap = lib.mkForce "uk";
  };
}
