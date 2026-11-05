{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.gaming.prism-launcher.enable {
  homebrew.casks = [ "prismlauncher" ];
}
