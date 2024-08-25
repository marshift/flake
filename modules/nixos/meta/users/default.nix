{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "nixos" "meta" "users" ];
  default = true;
  output = {
    # Despite everything, it's still you.
    users.users.marsh = {
      isNormalUser = true;
      name = "marsh";
      home = "/home/marsh";
      extraGroups = [
        "wheel"
        "audio"
        "video"
      ];
    };
  };
}
