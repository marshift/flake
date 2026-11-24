{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.development.android.enable {
  homebrew.casks = [ "android-studio" ];
}
