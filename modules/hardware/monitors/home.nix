{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf
  ((lib.lists.length osConfig.swamp.hardware.monitors != 0) && pkgs.stdenv.hostPlatform.isLinux)
  {
    services.kanshi = {
      enable = true;

      # TODO: Custom kanshi profiles?
      settings = [
        {
          profile = {
            name = "default";
            outputs = osConfig.swamp.hardware.monitors;
          };
        }
      ];
    };
  }
