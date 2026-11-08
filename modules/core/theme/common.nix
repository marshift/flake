{
  pkgs,
  ...
}:
{
  stylix = {
    enable = true;
    overlays.enable = false;

    polarity = "dark";
    base16Scheme = ./sorbet.yaml;

    image = ./blooming_hope.png;

    fonts = with pkgs; {
      sansSerif = {
        package = roboto;
        name = "Roboto";
      };
      serif = {
        package = roboto-slab;
        name = "Roboto Slab";
      };
      monospace = {
        package = roboto-mono;
        name = "Roboto Mono";
      };
      emoji = {
        package = noto-fonts-color-emoji;
        name = "Noto Emoji";
      };
    };
  };
}
