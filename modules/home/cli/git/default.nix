{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "cli" "git" ];
  default = true; # Flakes need git
  output = {
    programs.git = {
      enable = true;

      userName = "marshift";
      userEmail = "marshift@riseup.net";

      extraConfig = {
        init.defaultBranch = "master";
      };
    };
  };
}
