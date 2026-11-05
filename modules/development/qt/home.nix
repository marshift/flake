# TODO: This is only covering QtQuick at the moment
{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf osConfig.swamp.development.qt.enable {
  home.packages = with pkgs; [
    qt6.qtdeclarative
  ];
}
