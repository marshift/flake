{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf osConfig.swamp.development.typst.enable {
  home.packages = with pkgs; [
    typst
    typstyle
    tinymist
  ];
}
