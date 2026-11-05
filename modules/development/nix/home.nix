{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf osConfig.swamp.development.nix.enable {
  home.packages = with pkgs; [
    nixfmt
    nixd
  ];
}
