{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.desktop.wezterm.enable {
  homebrew.casks = [ "wezterm" ];
}
