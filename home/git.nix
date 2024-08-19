{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "marshift";
    userEmail = "marshift@riseup.net";

    extraConfig = {
      init.defaultBranch = "master";
    };
  };
}
