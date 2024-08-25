{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "nixos" "cli" "nano" ];
  default = true; # nano is my backup editor
  output = {
    programs.nano.enable = true;
  };
}
