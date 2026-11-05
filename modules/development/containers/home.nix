{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.development.containers.enable && pkgs.stdenv.hostPlatform.isDarwin)
  {
    home.packages = with pkgs; [
      colima
      docker-client
    ];
  }
