{
  pkgs,
  ...
}:
{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;

    package = pkgs.apple-cursor;
    name = "macOS";
    size = 32;
  };
}
