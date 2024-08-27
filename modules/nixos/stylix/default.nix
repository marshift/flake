{ config, lib, pkgs, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "nixos" "stylix" ];
  default = true;
  output = {
    stylix = {
      enable = true;
      polarity = "dark";
      image = ../../../assets/blooming_hope.png;
      base16Scheme = ./murky.yaml;
      fonts = {
        serif = {
          package = pkgs.roboto-slab;
          name = "Roboto Slab";
        };
        sansSerif = {
          package = pkgs.roboto;
          name = "Roboto";
        };
        monospace = {
          package = pkgs.fira-code;
          name = "Fira Code";
        };
        emoji = {
          package = pkgs.twitter-color-emoji;
          name = "TwitterColorEmoji";
        };
      };
    };
  };
}
