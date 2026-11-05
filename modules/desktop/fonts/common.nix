{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.fonts.enable =
    self.lib.options.mkEnableOptionWithDefault "the fonts I like" config.swamp.desktop.enable;

  config = lib.modules.mkIf config.swamp.desktop.fonts.enable {
    fonts.packages = with pkgs; [
      # System
      roboto
      roboto-slab
      roboto-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji

      # Other
      fira-code
    ];
  };
}
