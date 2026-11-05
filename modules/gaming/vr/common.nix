{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.gaming.vr.enable =
    lib.options.mkEnableOption "modules for Enterprise Resource Plan- I mean Virtual Reality";

  config.assertions = lib.modules.mkIf config.swamp.gaming.vr.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
