{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf osConfig.swamp.desktop.cursor.enable {
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;

    package = pkgs.apple-cursor;
    name = "macOS";
    size = 32;
  };
}
