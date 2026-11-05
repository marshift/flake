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

      # TODO: Support kanshi profiles "properly"?
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
