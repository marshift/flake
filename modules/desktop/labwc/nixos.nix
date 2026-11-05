{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.desktop.labwc.enable {
  programs.labwc.enable = true;
}
