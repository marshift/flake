{ config, lib, pkgs, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "desktop" "vscode" ];
  output = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      extensions = with pkgs; [
        vscode-extensions.jnoortheen.nix-ide
      ];
      mutableExtensionsDir = false;
    };
  };
}
