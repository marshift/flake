{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "cli" "gh" ];
  output = {
    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };
  };
}
