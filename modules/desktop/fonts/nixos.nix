{
  lib,
  config,
  ...
}:
let
  withCJKLangs =
    fontName:
    [ fontName ]
    ++ (lib.lists.map (lang: "${fontName} CJK ${lang}") [
      "JP"
      "KR"
      "SC"
      "TC"
      "HK"
    ]);
in
lib.modules.mkIf config.swamp.desktop.fonts.enable {
  fonts.fontconfig = {
    hinting.enable = false;
    subpixel.lcdfilter = "none";
    defaultFonts = {
      sansSerif = [ "Roboto" ] ++ withCJKLangs "Noto Sans";
      serif = [ "Roboto Slab" ] ++ withCJKLangs "Noto Serif";
      monospace = [ "Roboto Mono" ] ++ withCJKLangs "Noto Sans Mono";
      emoji = [ "Noto Emoji" ];
    };
  };
}
