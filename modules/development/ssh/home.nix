{
  lib,
  osConfig,
  ...
}:
lib.modules.mkIf osConfig.swamp.development.ssh.enable {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };
}
