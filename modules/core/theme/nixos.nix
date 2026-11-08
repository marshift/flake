{
  inputs,
  lib,
  pkgs,
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
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = withCJKLangs "Noto Sans";
        serif = withCJKLangs "Noto Serif";
        monospace = withCJKLangs "Noto Sans Mono";
      };

      hinting.enable = false;
      subpixel.lcdfilter = "none";
    };
  };
}
