{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf osConfig.swamp.development.android.enable {
  home.packages = [
    pkgs.android-tools
  ]
  ++ lib.lists.optional pkgs.stdenv.hostPlatform.isLinux pkgs.android-studio;
}
