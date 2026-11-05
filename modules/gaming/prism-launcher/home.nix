{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
mkIf osConfig.swamp.gaming.prism-launcher.enable {
  programs.prismlauncher = {
    package = mkIf pkgs.stdenv.hostPlatform.isDarwin null;
    enable = true;
    settings = {
      Language = "en_GB";
      ApplicationTheme = "Windows";
      IconTheme = "breeze_light";

      TheCat = true;
      CatOpacity = 30;
      BackgroundCat = "teawie";

      ShowConsole = true;
    };
  };
}
