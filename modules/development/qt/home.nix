# TODO: Actual Qt, not just QtQuick?
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
