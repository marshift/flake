{
  lib,
  osConfig,
  ...
}:
lib.modules.mkIf osConfig.swamp.development.dprint.enable {
  programs.dprint.enable = true;
}
